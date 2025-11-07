param(
    [Parameter(Mandatory = $true)]
    [string]$Version
)

Write-Host "==> Liberando version $Version..."

# --- Configurar identidad de GitHub Actions (para que pueda hacer commits y tags) ---
git config --global user.name "github-actions[bot]"
git config --global user.email "github-actions[bot]@users.noreply.github.com"

# --- Asegurar que estamos en la rama main ---
git checkout main

# --- Verificar si el tag ya existe ---
$existingTag = git tag --list "v$Version"
if ($existingTag) {
    Write-Host "La version v$Version ya existe. Se omite creacion del tag."
    exit 0
}

# --- Crear el tag y hacer push ---
try {
    git tag -a "v$Version" -m "Liberando version $Version"
    git push origin "v$Version"
    Write-Host "Version $Version liberada exitosamente y subida a GitHub."
}
catch {
    Write-Error "Error al liberar la version: $_"
    exit 1
}

