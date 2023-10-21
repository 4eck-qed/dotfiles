#!/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

TARGET_DIR="$1"
TARGET_GRP="$2"

pushd "$TARGET_DIR"
echo -e $YELLOW●$NC Setting ownership to $USER:$TARGET_GRP ..
chown -R $USER:$TARGET_GRP .
echo -e $GREEN●$NC ..done!

echo -e $YELLOW●$NC Adding rw permissions for group..
chmod -R g+rw .
echo -e $GREEN●$NC ..done!
popd
