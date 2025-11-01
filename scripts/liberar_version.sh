#!/usr/bin/env bash
set -euo pipefail

npm version patch -m "Liberando nueva versión %s"
git push origin main --tags
echo "Versión liberada"
