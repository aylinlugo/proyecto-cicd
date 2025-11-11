const express = require("express");
const bodyParser = require("body-parser");

const app = express();
const PORT = 3000;

app.use(bodyParser.urlencoded({ extended: true }));

let tareas = [];

app.get("/", (req, res) => {
  let html = "<h1>Mini App CI/CD - Gestión de Tareas</h1>";
  html += "<h2>Tareas:</h2><ul>";
  tareas.forEach(t => {
    html += `<li>${t.id} - ${t.titulo} [${t.completada ? "Completada" : "Pendiente"}]
              <a href='/completar/${t.id}'>Completar</a></li>`;
  });
  html += "</ul>";
  html 
  += `
    <h3>Agregar tarea</h3>
    <form method='POST' action='/agregar'>
      <input type='text' name='titulo' required/>
      <button type='submit'>Agregar</button>
    </form>
  `;
  res.send(html);
});

app.post("/agregar", (req, res) => {
  const tarea = { id: tareas.length + 1, titulo: req.body.titulo, completada: false };
  tareas.push(tarea);
  res.redirect("/");
});

app.get("/completar/:id", (req, res) => {
  const id = Number(req.params.id);
  const tarea = tareas.find(t => t.id === id);
  if (tarea) tarea.completada = true;
  res.redirect("/");
});

app.listen(PORT, () => {
  console.log(`Servidor ejecutándose en http://localhost:${PORT}`);


});