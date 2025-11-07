param(
    [Parameter(Mandatory = $true)]
    [string]$Version
)

Write-Host "==> Liberando version $Version..."

# Verificar si el tag ya existe
$tagExists = git tag -l "v$Version"
if ($tagExists) {
    Write-Host "La version v$Version ya existe. Se omite creacion del tag."
} else {
    git tag "v$Version"
    git push origin "v$Version"
}

Write-Host "==> Version $Version liberada exitosamente."
