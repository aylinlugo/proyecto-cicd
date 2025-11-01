#!/bin/bash
set -e  # Terminar si hay error

echo "==> Ejecutando pruebas del entorno"

# Verificar Node
node -v
npm -v

# Ejecutar pruebas (si tienes tests)
if [ -f package.json ]; then
  echo "==> Ejecutando npm test"
  npm test || { echo "Pruebas fallaron"; exit 1; }
fi

echo "==> Pruebas completadas exitosamente"
