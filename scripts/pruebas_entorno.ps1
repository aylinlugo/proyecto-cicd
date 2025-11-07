Write-Host "==> Ejecutando pruebas automáticas del entorno..."

# Cambiar a la carpeta de la aplicación
Set-Location "$PSScriptRoot/../app"

# Verificar si existe package.json
if (-Not (Test-Path "package.json")) {
    Write-Error "No se encontro package.json en la carpeta /app. Asegúrate de tenerlo antes de ejecutar las pruebas."
    exit 1
}

# Instalar dependencias
Write-Host "Instalando dependencias..."
npm install

# ==============================
# PRUEBA 1: Ejecutar 'npm test' (si existe)
# ==============================
if ((Get-Content package.json) -match '"test"') {
    Write-Host "==> Ejecutando 'npm test'..."
    npm test
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Las pruebas fallaron. Deteniendo pipeline."
        exit 1
    }
}

# ==============================
# PRUEBA 2: Validar sintaxis y ejecución
# ==============================
Write-Host "==> Verificando errores de sintaxis..."
node --check .\index.js
if ($LASTEXITCODE -ne 0) {
    Write-Error "Error de sintaxis en index.js."
    exit 1
}

# ==============================
# PRUEBA 3: Simular ejecución del servidor por unos segundos
# ==============================
Write-Host "==> Probando ejecución del servidor (3 segundos)..."

# Inicia el servidor en segundo plano
$process = Start-Process "node" ".\index.js" -PassThru

# Esperar unos segundos para comprobar que arranca sin fallar
Start-Sleep -Seconds 3

# Verificar si el proceso sigue vivo
if ($process.HasExited) {
    if ($process.ExitCode -ne 0) {
        Write-Error "El servidor fallo al iniciar (error de ejecución)."
        exit 1
    }
} else {
    # Si sigue corriendo, lo detenemos para evitar que bloquee el pipeline
    Stop-Process -Id $process.Id -Force
    Write-Host "El servidor inicio correctamente y fue detenido tras la prueba."
}

# Volver a la raíz
Set-Location "$PSScriptRoot/.."
Write-Host "==> Fin del proceso de pruebas automaticas."
