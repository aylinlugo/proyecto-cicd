#!/bin/bash
set -e  # Salir si hay un error

echo "===> Iniciando pruebas del entorno..."

# Ir a la carpeta de la app
cd app

# Instalar dependencias (si no se hizo antes)
npm install

# Ejecutar tests (si tienes tests en package.json)
if npm test; then
  echo "Todas las pruebas pasaron"
else
  echo "Algunas pruebas fallaron"
  exit 1
fi
