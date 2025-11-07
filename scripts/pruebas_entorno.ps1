Write-Host "==> Ejecutando pruebas automáticas del entorno..."

# Cambiar a la carpeta de la aplicación
Set-Location "$PSScriptRoot/../app"

# ==============================
# Verificar si existe package.json
# ==============================
if (-Not (Test-Path "package.json")) {
    Write-Error "❌ No se encontró package.json en la carpeta /app. Asegúrate de tenerlo antes de ejecutar las pruebas."
    exit 1
}

# ==============================
# Instalar dependencias
# ==============================
Write-Host "==> Instalando dependencias..."
npm install

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Error al instalar dependencias. Deteniendo pipeline."
    exit 1
}

# ==============================
# PRUEBA 1: Ejecución de npm test (si existe en package.json)
# ==============================
if ((Get-Content package.json) -match '"test"') {
    Write-Host "==> Ejecutando 'npm test'..."
    npm test
    if ($LASTEXITCODE -ne 0) {
        Write-Error "❌ Las pruebas fallaron. Deteniendo pipeline."
        exit 1
    } else {
        Write-Host "✅ Pruebas definidas en 'npm test' completadas exitosamente."
    }
} else {
    Write-Host "⚠️ No se encontró script 'test' en package.json. Continuando con verificación de sintaxis..."
}

# ==============================
# PRUEBA 2: Validar sintaxis sin ejecutar el servidor
# ==============================
Write-Host "==> Verificando errores de sintaxis en el código..."
try {
    node --check .\index.js
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Verificación de sintaxis completada correctamente."
    } else {
        Write-Error "❌ Se detectaron errores de sintaxis en index.js."
        exit 1
    }
}
catch {
    Write-Host "❌ Error detectado durante la verificación de sintaxis:"
    Write-Host $_.Exception.Message
    exit 1
}

# ==============================
# Volver a la carpeta raíz
# ==============================
Set-Location "$PSScriptRoot/.."

Write-Host "==> Fin del proceso de pruebas automáticas."
