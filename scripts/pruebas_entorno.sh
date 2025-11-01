#!/bin/bash
echo "===> Ejecutando pruebas..."
cd app       # Entrar a la carpeta donde está package.json
npm test || { echo "Pruebas fallaron"; exit 1; }
echo "Todas las pruebas pasaron correctamente."
