FROM node:18-alpine

# Carpeta de trabajo
WORKDIR /usr/src/app

# Copia package.json y package-lock.json de la carpeta app
COPY app/package*.json ./

# Instala dependencias de producción
RUN npm ci --only=production

# Copia todo el contenido de la carpeta app
COPY app/ ./

# Puerto que expondrá la app
EXPOSE 3000

# Healthcheck para Railway
HEALTHCHECK --interval=15s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:3000/health || exit 1

# Comando para iniciar la app
CMD ["node", "index.js"]
