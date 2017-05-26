#!/bin/sh

dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

configDir=/etc/vmware-caf/pme/config

#Preserve config
mkdir -p "$configDir"/_previous_
cp -pf "$configDir"/* "$configDir"/_previous_/ 2>/dev/null

#preserve state
