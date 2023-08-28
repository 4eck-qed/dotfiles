#!/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

USER='baron'
GROUP='localspecialty'


pushd /home/shared/
echo -e $YELLOW●$NC Setting ownership to $USER:$GROUP ..
chown -R $USER:$GROUP .
echo -e $GREEN●$NC ..done!

echo -e $YELLOW●$NC Adding rw permissions for group..
chmod -R g+rw .
echo -e $GREEN●$NC ..done!
popd
