// app/index.js - Versión mejorada y segura
const express = require('express');
const bodyParser = require('body-parser');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const fs = require('fs');
const path = require('path');

const app = express();
const DATA_FILE = path.join(__dirname, 'tareas.json');
const PORT = process.env.PORT || 3000;

app.use(helmet());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Rate limiting básico
app.set('trust proxy', 1);
const limiter = rateLimit({ windowMs: 15*60*1000, max: 100 });
app.use(limiter);

// Cargar tareas de forma segura
let tareas = [];
try {
  if (fs.existsSync(DATA_FILE)) {
    const raw = fs.readFileSync(DATA_FILE, 'utf8');
    tareas = JSON.parse(raw) || [];
  }
} catch (e) {
  console.error('No se pudo leer tareas:', e.message);
  tareas = [];
}

function saveTareas() {
  try {
    fs.writeFileSync(DATA_FILE, JSON.stringify(tareas, null, 2), { encoding: 'utf8' });
  } catch (e) {
    console.error('Error guardando tareas:', e.message);
  }
}

function sanitizeTitle(t) {
  if (typeof t !== 'string') return '';
  return t.replace(/[<>]/g, '').trim().slice(0, 200);
}

app.get('/', (req, res) => {
  let html = '<h1>Mini App CI/CD - Gestión de Tareas (Mejorada)</h1>';
  html += '<h2>Tareas:</h2><ul>';
  tareas.forEach(t => {
    html += `<li>${t.id} - ${t.titulo} [${t.completada ? "Completada" : "Pendiente"}]
              <a href="/completar/${t.id}">Completar</a></li>`;
  });
  html += '</ul>';
  html += `
    <h3>Agregar tarea</h3>
    <form method="POST" action="/agregar">
      <input type="text" name="titulo" required/>
      <button type="submit">Agregar</button>
    </form>
  `;
  res.send(html);
});

app.post('/agregar', (req, res) => {
  const titulo = sanitizeTitle(req.body.titulo);
  if (!titulo) return res.status(400).send('Título inválido');
  const tarea = { id: tareas.length + 1, titulo, completada: false };
  tareas.push(tarea);
  saveTareas();
  res.redirect('/');
});

app.get('/completar/:id', (req, res) => {
  const id = Number(req.params.id);
  const tarea = tareas.find(t => t.id === id);
  if (tarea) {
    tarea.completada = true;
    saveTareas();
  }
  res.redirect('/');
});

// Exportar app para tests sin iniciar servidor
module.exports = app;

if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`Servidor ejecutándose en http://localhost:${PORT}`);
  });
}
