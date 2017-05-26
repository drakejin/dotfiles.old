#!/bin/bash

#Args
#brokerAddr
#	- default: 
#baseLibDir
#	- default: /usr/lib
#	- expand to "$baseLibDir"/vmware-caf/pme
#
#baseInputDir
#	- default: /var/lib
#	- expand to "$baseInputDir"/vmware-caf/pme/data/input
#
#baseOutputDir
#	- default: /var/lib
#	- expand to "$baseOutputDir"/vmware-caf/pme/data/output

#Standard env
SCRIPT=`basename "$0"`
THIS_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

#Set defaults
baseLibDir='/usr/lib'
baseInputDir='/var/lib'
baseOutputDir='/var/lib'
installType='pme'
brokerAddr=''

#Help function
function HELP {
	echo -e \\n"Help documentation for ${SCRIPT}."\\n
	echo -e "Basic usage: $SCRIPT"\\n
	echo "Command line switches are optional. The following switches are recognized."
	echo "b  --Sets the value for the broker address. Default is '$brokerAddr'."
	echo "i  --Sets the base location for the input data. Default is '$baseInputDir'."
	echo "l  --Sets the base location for the libraries. Default is '$baseLibDir'."
	echo "o  --Sets the base location for the output data. Default is '$baseOutputDir'."
	echo -e "c  --Configures for client."\\n
	echo -e "h  --Displays this help message. No further functions are performed."\\n
	echo -e "p  --Configures for PME (default)"\\n
	echo -e "Example: $SCRIPT -b 10.25.57.249 -i \"/usr/lib\" -i \"/var/lib\" -o \"/var/lib\""\\n
	exit 1
}

#Replace tokens with install values
setupCafConfig() {
	pattern="$1"
	value="$2"
	rconfigDir="$3"
	rscriptDir="$4"

	if [ ! -n "$pattern" ]; then
		echo 'The pattern cannot be empty!'
		exit 1
	fi

	if [ -n "$value" ]; then
		if [ -d "$rconfigDir" ]; then
			for file in $(egrep -rl "$pattern" "$rconfigDir"/*); do
				basefile=$(basename "$file")
				#echo "Replacing $pattern with $value - $basefile"
				sed -i "s?$pattern?$value?g" "$file"
			done
		fi
		if [ -d "$rscriptDir" ]; then
			for file in $(egrep -rl "$pattern" "$rscriptDir"/*); do
				basefile=$(basename "$file")
				#echo "Replacing $pattern with $value - $basefile"
				sed -i "s?$pattern?$value?g" "$file"
			done
		fi
	else
		#echo "$pattern is empty, skipping"
		:
	fi
}

##BEGIN Main

#Get Optional overrides
while getopts ":b:i:l:o:h" opt; do
	case $opt in
		b)
			brokerAddr="$OPTARG"
			;;
		i)
			baseInputDir="$OPTARG"
			;;
		l)
			baseLibDir="$OPTARG"
			;;
		o)
			baseOutputDir="$OPTARG"
			;;
		c)
			HELP
			;;
		h)
			installType='client'
			;;
		p)
			installType='pme'
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			HELP
			;;
	esac
done

#Expand variables
stdQuals="vmware-caf/$installType"
libDir="$baseLibDir"/"$stdQuals"
inputDir="$baseInputDir"/"$stdQuals"/data/input
outputDir="$baseOutputDir"/"$stdQuals"/data/output

cafInstallDir="$baseLibDir/vmware-caf"
baseEtcDir="/etc/$stdQuals"
installScriptDir="$baseEtcDir/install"
scriptDir="$baseEtcDir/scripts"
configDir="$baseEtcDir/config"
cafProvidersDir="$inputDir/providers"
cafInvokersDir="$inputDir/invokers"
cafLogDir="/var/log/$stdQuals"
pmeId=`uuidgen`

#Ensure directories exist
mkdir -p "$cafInvokersDir"
mkdir -p "$cafProvidersDir"
mkdir -p "$cafLogDir"

#Substitute values into config files
setupCafConfig '@installDir@' "$cafInstallDir" "$configDir" "$scriptDir"
setupCafConfig '@brokerAddr@' "$brokerAddr" "$configDir" "$scriptDir"
setupCafConfig '@libDir@' "$libDir/lib" "$configDir" "$scriptDir"
setupCafConfig '@binDir@' "$libDir/bin" "$configDir" "$scriptDir"
setupCafConfig '@configDir@' "$configDir" "$configDir" "$scriptDir"
setupCafConfig '@inputDir@' "$inputDir" "$configDir" "$scriptDir"
setupCafConfig '@outputDir@' "$outputDir" "$configDir" "$scriptDir"
setupCafConfig '@providersDir@' "$cafProvidersDir" "$configDir" "$scriptDir"
setupCafConfig '@invokersDir@' "$cafInvokersDir" "$configDir" "$scriptDir"
setupCafConfig '@logDir@' "$cafLogDir" "$configDir" "$scriptDir"
setupCafConfig '@pmeId@' "$pmeId" "$configDir" "$scriptDir"
setupCafConfig '@scriptDir@' "$scriptDir" "$configDir" "$scriptDir"

. "$configDir"/cafenv.config

#Set default permissions
if [ -d "$libDir" ]; then
	for directory in $(find "$libDir" -type d); do
		chmod 755 "$directory"
	done

	for file in $(find "$libDir" -type f); do
		chmod 555 "$file"
	done
fi

if [ -d "$inputDir" ]; then
	for file in $(find "$inputDir" -type f); do
		chmod 644 "$file"
	done

	if [ -d "$inputDir/certs" ]; then
		for file in $(find "$inputDir/certs" -type f); do
			chmod 440 "$file"
		done
	fi
fi

if [ -d "$scriptDir" ]; then
		chmod 555 "$directory"/*
fi

#Set up links
cd "$CAF_LIB_DIR"
ln -sf libglib-2.0.so.0.3400.3 libglib-2.0.so
ln -sf libglib-2.0.so.0.3400.3 libglib-2.0.so.0
ln -sf libgthread-2.0.so.0.3400.3 libgthread-2.0.so
ln -sf libgthread-2.0.so.0.3400.3 libgthread-2.0.so.0
ln -sf liblog4cpp.so.5.0.6 liblog4cpp.so
ln -sf liblog4cpp.so.5.0.6 liblog4cpp.so.5
ln -sf librabbitmq.so.4.1.2 librabbitmq.so
ln -sf librabbitmq.so.4.1.2 librabbitmq.so.4

#Run provider install logic
installPProviders="$installScriptDir"/installPythonProviders.sh
if [ -e "$installPProviders" ]; then
        "$installPProviders"
fi

#if previous CAF installation
	#migrate config
	#migrate other state
