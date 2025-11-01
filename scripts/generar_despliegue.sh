#!/usr/bin/env bash
set -euo pipefail

# Variables necesarias
: "${DEPLOY_USER:?Falta DEPLOY_USER}"
: "${DEPLOY_HOST:?Falta DEPLOY_HOST}"
: "${DEPLOY_PATH:?Falta DEPLOY_PATH}"
: "${SSH_KEY_PATH:?Falta SSH_KEY_PATH}"
: "${APP_NAME:?Falta APP_NAME}"

TIMESTAMP=$(date +%Y%m%d%H%M%S)
RELEASE_DIR="${DEPLOY_PATH}/releases/${TIMESTAMP}"
CURRENT_LINK="${DEPLOY_PATH}/current"

echo "===> Creando release en servidor..."
ssh -i "$SSH_KEY_PATH" $DEPLOY_USER@$DEPLOY_HOST "mkdir -p $RELEASE_DIR"

echo "===> Empaquetando app..."
tar --exclude='./node_modules' --exclude='.git' -czf /tmp/app.tar.gz -C app .

echo "===> Subiendo paquete al servidor..."
scp -i "$SSH_KEY_PATH" /tmp/app.tar.gz $DEPLOY_USER@$DEPLOY_HOST:$RELEASE_DIR/

echo "===> Preparando release en servidor..."
ssh -i "$SSH_KEY_PATH" $DEPLOY_USER@$DEPLOY_HOST bash -lc "
  set -euo pipefail
  cd $RELEASE_DIR
  tar -xzf app.tar.gz
  rm app.tar.gz
  npm ci --production
  ln -sfn $RELEASE_DIR $CURRENT_LINK
  sudo systemctl restart $APP_NAME.service
"

echo "===> Despliegue completado"
rm -f /tmp/app.tar.gz
