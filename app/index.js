// ERROR_INSECURE_EVAL - app/index.js
const express = require('express');
const app = express();
const PORT = 3000;

// PELIGRO: eval con entrada del usuario (ejemplo didáctico)
app.get('/calc', (req, res) => {
  const expr = req.query.expr || '2+2';
  // Uso de eval es inseguro — pipeline debe detectarlo con ESLint o check_security
  const result = eval(expr);
  res.send(`Resultado: ${result}`);
});

app.get('/', (req, res) => {
  res.send('<h1>Endpoint /calc disponible (inseguro)</h1>');
});

app.listen(PORT, () => {
  console.log(`Servidor en http://localhost:${PORT}`);
});
