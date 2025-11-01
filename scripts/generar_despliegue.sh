#!/bin/bash
set -e  # Salir si hay un error

echo "===> Iniciando despliegue.

# Variables
DEPLOY_USER=${DEPLOY_USER}
DEPLOY_HOST=${DEPLOY_HOST}
DEPLOY_PATH=${DEPLOY_PATH}
SSH_KEY_PATH=${SSH_KEY_PATH}
APP_NAME=${APP_NAME}
NODE_ENV=${NODE_ENV}
GIT_COMMIT=${GIT_COMMIT}

# Conectar al servidor y desplegar
ssh -i "$SSH_KEY_PATH" "$DEPLOY_USER@$DEPLOY_HOST" << EOF
  echo "Desplegando $APP_NAME en $DEPLOY_PATH"
  cd $DEPLOY_PATH || mkdir -p $DEPLOY_PATH && cd $DEPLOY_PATH
  git fetch --all
  git reset --hard $GIT_COMMIT
  npm install --production
  pm2 restart $APP_NAME || pm2 start app/index.js --name "$APP_NAME" --env $NODE_ENV
EOF

echo "Despliegue completado"
