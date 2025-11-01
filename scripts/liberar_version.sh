#!/bin/bash
echo "===> Liberando nueva version..."
VERSION="v$(date +'%Y%m%d%H%M')"
git tag $VERSION
git push origin $VERSION
echo "Version $VERSION liberada correctamente."
