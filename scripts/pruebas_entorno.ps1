Write-Host "==> Ejecutando pruebas..."

# Ejecutar pruebas desde /app
Set-Location "$PSScriptRoot/../app"
npm test

if ($LASTEXITCODE -eq 0) {
    Write-Host "==> Pruebas completadas exitosamente."
} else {
    Write-Error "Las pruebas fallaron. Deteniendo pipeline."
    exit 1
}

# Regresar a la raíz
Set-Location "$PSScriptRoot/.."
