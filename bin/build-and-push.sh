#!/bin/bash

POINTS=(8 10 12 14 16 18 20 22 24 26 28 30)

for POINT in "${POINTS[@]}"; do
    VERSION="5.$POINT"
    echo $VERSION
    TAG=oalders/tester-perl:$VERSION
    docker build . --build-arg BASE=$VERSION --tag $TAG && docker push $TAG
done
