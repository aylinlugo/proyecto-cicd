#!/bin/bash
set -e

echo "Iniciando pruebas del entorno"

# Revisar versión de Node
echo "Node.js version:"
node -v

# Revisar versión de npm
echo "npm version:"
npm -v

# Revisar dependencias instaladas
echo "Dependencias instaladas:"
npm list --depth=0

echo "Pruebas del entorno completadas"
