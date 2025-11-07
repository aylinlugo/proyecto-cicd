// ERROR_RUNTIME_READ - app/index.js
const express = require('express');
const fs = require('fs');
const app = express();
const PORT = 3000;

// Al requerir/ejecutar este archivo intentará leer un archivo que no existe y lanzará excepción
const data = fs.readFileSync('C:\\ruta\\que\\no\\existe.txt', 'utf8');
console.log(data);

app.get('/', (req, res) => {
  res.send('<h1>Si ves esto, no hubo crash</h1>');
});

app.listen(PORT, () => {
  console.log(`Servidor en http://localhost:${PORT}`);
});
