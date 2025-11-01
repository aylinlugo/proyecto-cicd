# Proyecto CI/CD

Este proyecto implementa un pipeline de Integración y Despliegue Continuo (CI/CD) utilizando **GitHub Actions**.

## 🧩 Estructura del repositorio

```
proyecto-cicd/
├── .github/workflows/
│   └── ci_cd_pipeline.yml     # Pipeline principal
├── scripts/
│   ├── generar_entorno.sh     # Crea entorno
│   ├── pruebas_entorno.sh     # Ejecuta pruebas
│   ├── liberar_version.sh     # Genera versión liberada
│   └── generar_despliegue.sh  # Despliega app
├── app/
│   └── index.js               # Código de ejemplo
└── README.md
```

## 🚀 Cómo funciona

Cada vez que haces **git push** a la rama `main`, GitHub Actions ejecuta:

1. `scripts/generar_entorno.sh` — prepara el entorno.
2. `scripts/pruebas_entorno.sh` — ejecuta las pruebas.
3. `scripts/liberar_version.sh` — genera un tag de versión.
4. `scripts/generar_despliegue.sh` — despliega la app.

Puedes ver el flujo en la pestaña **Actions** de GitHub.
