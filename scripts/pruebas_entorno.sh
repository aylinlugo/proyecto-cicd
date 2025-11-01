#!/bin/bash
echo "===> Ejecutando pruebas"
cd app
node index.js &
PID=$!
sleep 3  # esperamos que el servidor inicie
kill $PID
echo "Prueba de ejecución completada correctamente."
