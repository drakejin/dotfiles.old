#!/bin/sh

dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

configDir=/etc/vmware-caf/pme/config

#Restore previous config
if [ -d "$configDir"/_previous_ ]; then
	mv -f "$configDir"/_previous_/* "$configDir"
	rmdir "$configDir"/_previous_
fi

# Make newer systemd systems (OpenSuSE 13.2) happy
#if [ -x /usr/bin/systemctl ]; then
#    /usr/bin/systemctl daemon-reload
#fi

#"$dir"/restartServices.sh

. $configDir/cafenv.config
cd $CAF_LIB_DIR
ln -sf libglib-2.0.so.0.3400.3 libglib-2.0.so
ln -sf libglib-2.0.so.0.3400.3 libglib-2.0.so.0
ln -sf libgthread-2.0.so.0.3400.3 libgthread-2.0.so
ln -sf libgthread-2.0.so.0.3400.3 libgthread-2.0.so.0
ln -sf liblog4cpp.so.5.0.6 liblog4cpp.so
ln -sf liblog4cpp.so.5.0.6 liblog4cpp.so.5
ln -sf librabbitmq.so.4.1.2 librabbitmq.so
ln -sf librabbitmq.so.4.1.2 librabbitmq.so.4
