Write-Host "==> Generando entorno de despliegue..."

$rootPath = "$PSScriptRoot/.."
$appPath = "$rootPath/app"
$buildPath = "$rootPath/build"

# Crear carpeta de build si no existe
if (!(Test-Path $buildPath)) {
    New-Item -ItemType Directory -Force -Path $buildPath | Out-Null
}

# Copiar archivos necesarios desde /app
Copy-Item -Force "$appPath/package.json" "$buildPath/package.json"
Copy-Item -Force "$appPath/test.js" "$buildPath/test.js"
Copy-Item -Recurse -Force "$appPath/index.js" "$buildPath/index.js"

Write-Host "==> Entorno de despliegue generado correctamente en /build"
