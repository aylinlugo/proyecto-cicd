#!/usr/bin/env bash
set -euo pipefail

echo "===> Instalando dependencias"
npm ci

echo "===> Ejecutando pruebas unitarias y linters..."

# Validar que hay un script de test
if grep -q "\"test\"" package.json; then
  npm test
else
  echo "No se detectó script de test en package.json, saltando pruebas."
fi

# Linter opcional (si tienes ESLint configurado)
if [ -f ".eslintrc.json" ]; then
  npx eslint app/**/*.js
fi

echo "===> Validaciones completadas"
