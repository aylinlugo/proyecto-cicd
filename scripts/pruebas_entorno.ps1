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
# PRUEBA 2: Validar sintaxis del código (aunque no haya tests)
# ==============================
Write-Host "==> Verificando errores de sintaxis en el código..."
try {
    node .\index.js
    Write-Host "✅ Pruebas completadas correctamente. No se detectaron errores de ejecución."
}
catch {
    Write-Host "❌ Error detectado durante la verificación de sintaxis:"
    Write-Host $_.Exception.Message
    exit 1
}

# Volver a la carpeta raíz
Set-Location "$PSScriptRoot/.."

Write-Host "==> Fin del proceso de pruebas automáticas."
