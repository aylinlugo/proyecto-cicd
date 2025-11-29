const express = require("express");
const bodyParser = require("body-parser");
const promBundle = require("express-prom-bundle");
const promClient = require("prom-client");

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware para métricas Prometheus
const metricsMiddleware = promBundle({
  includeMethod: true,
  includePath: true,
  includeStatusCode: true,
  promClient: {
    collectDefaultMetrics: {}
  }
});
app.use(metricsMiddleware);

// Contador de requests exitosas (SLI)
const successCounter = new promClient.Counter({
  name: 'http_requests_success_total',
  help: 'Cantidad de requests exitosas (HTTP 2xx)'
});

app.use((req, res, next) => {
  res.on('finish', () => {
    if(res.statusCode >= 200 && res.statusCode < 300) successCounter.inc();
  });
  next();
});

// Middleware body parser
app.use(bodyParser.urlencoded({ extended: true }));

// Arreglo de tareas
let tareas = [];

// Página principal con lista de tareas y formulario para agregar
app.get("/", (req, res) => {
  let html = "<h1>Mini App CI/CD - Gestión de Tareas</h1>";
  html += "<h2>Tareas:</h2><ul>";
  tareas.forEach(t => {
    html += `<li>${t.id} - ${t.titulo} [${t.completada ? "Completada" : "Pendiente"}]
              <a href='/completar/${t.id}'>Completar</a></li>`;
  });
  html += "</ul>";
  html += `
    <h3>Agregar tarea</h3>
    <form method='POST' action='/agregar'>
      <input type='text' name='titulo' required/>
      <button type='submit'>Agregar</button>
    </form>
  `;
  res.send(html);
});

// Healthcheck para CI/CD
app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

// Endpoint para agregar tareas
app.post("/agregar", (req, res) => {
  const tarea = { id: tareas.length + 1, titulo: req.body.titulo, completada: false };
  tareas.push(tarea);
  res.redirect("/");
});

// Endpoint para completar tareas
app.get("/completar/:id", (req, res) => {
  const id = Number(req.params.id);
  const tarea = tareas.find(t => t.id === id);
  if (tarea) tarea.completada = true;
  res.redirect("/");
});

// Export para pruebas unitarias
module.exports = app;

// Levantar servidor solo si se ejecuta directamente
if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`Servidor ejecutándose en http://localhost:${PORT}`);
  });
}
