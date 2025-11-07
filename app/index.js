// app/index.js  <-- versión con fallo en runtime
const fs = require('fs');

// fallará cuando se requiera si el archivo no existe o no se puede leer:
const data = fs.readFileSync('C:\\ruta\\que\\no\\existe.txt', 'utf8');

console.log(data);

module.exports = {}; 
