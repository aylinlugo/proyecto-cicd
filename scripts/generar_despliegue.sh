#!/bin/bash
echo "===> Iniciando despliegue"
cd app
node index.js &
sleep 3  # simulamos que el servidor corre
kill $!
echo "Despliegue se ha completado."
