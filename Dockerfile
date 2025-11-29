# app/Dockerfile está fuera de la carpeta app
FROM node:18-alpine

# Directorio de trabajo dentro del contenedor
WORKDIR /usr/src/app

# Copiamos solo package.json y package-lock.json primero para cachear npm ci
COPY app/package*.json ./

# Instalamos dependencias en modo producción
RUN npm ci --only=production

# Copiamos todo el contenido de la carpeta app
COPY app/ . 

# Puerto expuesto
EXPOSE 3000

# Healthcheck para CI/CD
HEALTHCHECK --interval=15s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:3000/health || exit 1

# Comando para iniciar la app
CMD ["node", "index.js"]
