Write-Host "==> Ejecutando pruebas automáticas del entorno..."

# Cambiar a la carpeta de la aplicación
Set-Location "$PSScriptRoot/../app"

# Verificar si existe package.json
if (-Not (Test-Path "package.json")) {
    Write-Error "❌ No se encontró package.json en la carpeta /app. Asegúrate de tenerlo antes de ejecutar las pruebas."
    exit 1
}

# Instalar dependencias
Write-Host "==> Instalando dependencias..."
npm install

# ==============================
# PRUEBA 1: Ejecución de npm test (si existe)
# ==============================
if ((Get-Content package.json) -match '"test"') {
    Write-Host "==> Ejecutando 'npm test'..."
    npm test
    if ($LASTEXITCODE -ne 0) {
        Write-Error "❌ Las pruebas fallaron. Deteniendo pipeline."
        exit 1
    }
}

# ==============================
# PRUEBA 2: Validar sintaxis y ejecución del código
# ==============================
Write-Host "==> Verificando errores de sintaxis y ejecución..."

# 1️⃣ Verificación de sintaxis pura
node --check .\index.js
if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Error de sintaxis en index.js. Corrige el código antes de continuar."
    exit 1
}

# 2️⃣ Ejecución del código para detectar errores de runtime
node .\index.js
if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Error de ejecución detectado en index.js. El código no se ejecutó correctamente."
    exit 1
}

Write-Host "✅ Pruebas completadas correctamente. No se detectaron errores de sintaxis ni ejecución."

# Volver a la carpeta raíz
Set-Location "$PSScriptRoot/.."

Write-Host "==> Fin del proceso de pruebas automáticas."
