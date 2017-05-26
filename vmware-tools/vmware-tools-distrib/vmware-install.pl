#!/bin/sh
LOGFILE=/var/log/vmware-install.log
dir=`dirname $0`

echo "VMware Tools installation start `date`" >> ${LOGFILE}
${dir}/vmware-install.real.pl "$@" 2>&1 | tee -a ${LOGFILE}
echo "VMware Tools installation end `date`" >> ${LOGFILE}

