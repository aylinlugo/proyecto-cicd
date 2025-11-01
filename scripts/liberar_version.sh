#!/bin/bash
echo "===> Liberando nueva versión..."
VERSION="v$(date +'%Y%m%d%H%M')"
git tag $VERSION
git push origin $VERSION
echo "Versión $VERSION liberada correctamente."
