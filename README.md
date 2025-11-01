Proyecto CI/CD

Este proyecto implementa un pipeline de Integración y Despliegue Continuo (CI/CD) utilizando **GitHub Actions**.

 Estructura del repositorio
proyecto-cicd/
├── .github/workflows/
│   └── ci_cd_pipeline.yml     # Pipeline principal
├── scripts/
│   ├── generar_entorno.sh     # Prepara el entorno
│   ├── pruebas_entorno.sh     # Ejecuta pruebas
│   ├── liberar_version.sh     # Crea versión liberada
│   └── generar_despliegue.sh  # Despliega la app
├── app/
│   ├── index.js               # Código de la aplicación
│   └── package.json           # Configuración de Node.js
└── README.md

 Cómo funciona el proyecto

Al realizar un git push a la rama main:
Preparación del entorno (scripts/generar_entorno.sh)
Instala todas las dependencias necesarias con npm install.
Garantiza que la aplicación pueda ejecutarse en cualquier entorno.

Ejecución de pruebas (scripts/pruebas_entorno.sh)
Ejecuta los tests definidos en package.json.
Si alguna prueba falla, el pipeline se detiene y no se libera la versión.

Liberación de la versión (scripts/liberar_version.sh)
Genera un tag de versión basado en la fecha y hora.
Permite llevar un control de versiones y mantener un historial claro de cambios.

Despliegue de la aplicación (scripts/generar_despliegue.sh)
Simula el despliegue de la aplicación.
Confirma que los cambios fueron liberados correctamente.
Cada commit a main dispara automáticamente este flujo, asegurando que la aplicación esté siempre probada y lista para producción.

Requisitos para ejecutar localmente
Tener Node.js y npm instalados.
Desde la carpeta app/:
npm install     # Instala dependencias
npm start       # Ejecuta la aplicación
npm test        # Corre pruebas simuladas


Para probar los scripts de pipeline localmente:
bash scripts/generar_entorno.sh
bash scripts/pruebas_entorno.sh
bash scripts/liberar_version.sh
bash scripts/generar_despliegue.sh


Esto permite verificar que cada etapa funciona correctamente antes de subir los cambios al remoto.

Monitoreo y estado del pipeline
Los resultados de cada ejecución se pueden revisar en GitHub Actions.
Si un paso falla, el workflow se detiene automáticamente y no se libera ni despliega la versión.
Esto asegura que solo código validado llegue al entorno de producción.

Nota final
Este proyecto sirve como ejemplo funcional de CI/CD para fines académicos, con scripts listos para ser ampliados, incluyendo pruebas más completas y despliegues automáticos a servidores de producción.
