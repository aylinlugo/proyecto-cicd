Write-Host "==> Generando entorno..."

# Instalar dependencias desde /app
Set-Location "$PSScriptRoot/../app"
npm install

if ($LASTEXITCODE -eq 0) {
    Write-Host "==> Dependencias instaladas correctamente."
} else {
    Write-Error "Error al instalar dependencias. Deteniendo pipeline."
    exit 1
}

# Regresar a la raíz del proyecto
Set-Location "$PSScriptRoot/.."
