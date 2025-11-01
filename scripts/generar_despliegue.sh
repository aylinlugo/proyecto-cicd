#!/bin/bash
set -e

echo "==> Conectando al servidor $DEPLOY_HOST"

ssh -i "$SSH_KEY_PATH" "$DEPLOY_USER@$DEPLOY_HOST" << EOF
  set -e
  echo "==> Navegando al directorio de la aplicación: $DEPLOY_PATH"
  cd $DEPLOY_PATH

  echo "==> Deteniendo aplicación existente (si existe)"
  pm2 stop $APP_NAME || true

  echo "==> Actualizando código desde GitHub"
  git fetch --all
  git reset --hard origin/main

  echo "==> Instalando dependencias en el servidor"
  npm install

  echo "==> Iniciando aplicación con PM2"
  NODE_ENV=$NODE_ENV pm2 start index.js --name "$APP_NAME"

  echo "==> Despliegue completado con éxito"
EOF
