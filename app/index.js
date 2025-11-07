// ERROR_SINTAXIS - app/index.js
const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  // Falta paréntesis y llave de cierre -> SyntaxError
  res.send("<h1>Inicio - Error de sintaxis</h1>"
);

app.listen(PORT, () => {
  console.log(`Servidor en http://localhost:${PORT}`);
});
