#!/bin/bash
set -e

echo "Iniciando despliegue de la aplicación"

# Variables de entorno
echo "Desplegando $APP_NAME a $DEPLOY_HOST:$DEPLOY_PATH"

# Copiar archivos al servidor
scp -i $SSH_KEY_PATH -r app/* $DEPLOY_USER@$DEPLOY_HOST:$DEPLOY_PATH

# Conectarse por SSH y reiniciar la app (Node.js ejemplo)
ssh -i $SSH_KEY_PATH $DEPLOY_USER@$DEPLOY_HOST << EOF
cd $DEPLOY_PATH
npm install --production
pm2 restart $APP_NAME || pm2 start index.js --name "$APP_NAME"
EOF

echo "Despliegue completado"
