// app/index.js con error intencional
const express = require("express")
const bodyParser = require("body-parser")

const app = express()
const PORT = 3000

app.use(bodyParser.urlencoded({ extended: true }))

// ❌ ERROR: Falta paréntesis y llave de cierre
app.get("/", (req, res) => {
  res.send("<h1>App con error</h1>")

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`Servidor ejecutándose en http://localhost:${PORT}`)
})
