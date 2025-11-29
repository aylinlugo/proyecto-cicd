FROM node:18-alpine

WORKDIR /usr/src/app

# Copiar package.json y package-lock.json primero
COPY app/package*.json ./

# Instalar dependencias de producción
RUN npm ci --only=production

# Copiar todo el contenido de la carpeta app
COPY app/ .

# Exponer puerto
EXPOSE 3000

# Healthcheck
HEALTHCHECK --interval=15s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:3000/health || exit 1

# Comando para iniciar la app
CMD ["node", "index.js"]
