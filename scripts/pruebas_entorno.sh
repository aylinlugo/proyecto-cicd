#!/bin/bash
echo "===> Ejecutando pruebas..."
npm test || { echo "❌ Pruebas fallaron"; exit 1; }
echo "✅ Todas las pruebas pasaron correctamente."
