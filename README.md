App CI/CD - Gestión de Tareas

## Descripción
Esta es una aplicación sencilla de gestión de tareas desarrollada en Node.js.  
Permite crear, listar y gestionar tareas de forma funcional, y ahora incluye un archivo adicional que se genera automáticamente dentro de la carpeta `app`.  

El proyecto está preparado para integrarse en un flujo de CI/CD y puede ejecutarse de manera local o en servidores de integración continua sin problemas.

## Estructura del Proyecto
La rama principal (main) del proyecto tiene la siguiente estructura:

main/
│
├─ .github/workflows/
│ └─ ci_cd_pipeline.yml # Archivo de configuración del pipeline CI/CD
│
├─ app/
│ ├─ index.js # Archivo principal de la aplicación
│ ├─ package.json # Dependencias y scripts de Node.js
│ └─ package-lock.json # Registro exacto de dependencias instaladas
│
├─ scripts/
│ ├─ generar_despliegue.sh # Script para generar el despliegue
│ ├─ generar_entorno.sh # Script para configurar el entorno
│ ├─ liberar_version.sh # Script para liberar nuevas versiones
│ └─ pruebas_entorno.sh # Script para pruebas del entorno
│
└─ README.md # Documentación del proyecto


#Flujo CI/CD

El proyecto está configurado con un pipeline automático que se ejecuta cada vez que haces un push o un pull request a la rama main.

Pasos del pipeline
Build: Se asegura de que la aplicación se pueda instalar y ejecutar correctamente.
Test: Ejecuta pruebas unitarias (si las hubiera) para garantizar que no haya errores.
Deploy: Publica la aplicación o ejecuta un script que deje el proyecto listo para producción.

#Beneficios de CI/CD en este proyecto
Evita errores por integración manual.
Garantiza que cada commit pase por un pipeline de pruebas.
Permite desplegar la aplicación de forma confiable y rápida.
Facilita el trabajo colaborativo en equipo.
