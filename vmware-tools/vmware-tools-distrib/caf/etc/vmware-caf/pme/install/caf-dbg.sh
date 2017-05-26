#!/bin/bash

function prtHeader() {
   local header=$1

   echo "*************************"
   echo "***"
   echo "*** $header"
   echo "***"
   echo "*************************"
}

function setCafRootDir() {
   if [ "$CAF_CONFIG_DIR" = "" ]; then
      if [ -f "/etc/vmware-caf/pme/config/cafenv.config" ]; then
         . "/etc/vmware-caf/pme/config/cafenv.config"
      else
         if [ -f "/etc/vmware-caf/client/config/cafenv.config" ]; then
            . "/etc/vmware-caf/client/config/cafenv.config"
         else
            echo "Failed to resolve cafenv.config"
            exit 1
         fi
      fi
   fi
}

function validateNotEmpty() {
   local value=$1
   local name=$2

   if [ "$value" = "" ]; then
      echo "Value cannot be empty - $name"
      exit 1
   fi
}

function enableCaf() {
   local username="$1"
   local password="$2"
   validateNotEmpty "$username" "username"
   validateNotEmpty "$password" "password"

   setCafRootDir

   egrep -qw "amqp_username|amqp_password" "$CAF_CONFIG_DIR/CommAmqpListener-appconfig"; isFnd="$?"
   if [ "$isFnd" = "1" ]; then
      sed -i "s/\[communication_amqp\]/[communication_amqp]\namqp_username=${username}\namqp_password=${password}/g" "$CAF_CONFIG_DIR/CommAmqpListener-appconfig"
   fi
}

function prtHelp() {
   echo "*** $0 cmd <args>"
   echo "  Runs various CAF commands"
   echo "    cmd: The CAF command to run:"
   echo "      * enableCaf brokerUsername brokerPassword    Enables CAF"
   echo ""
   echo "      * checkTunnel                                Checks the AMQP Tunnel "
   echo "      * checkCerts                                 Checks the certificates"
   echo "      * checkCertsVerbose                          Checks the certificates"
   echo ""
   echo "      * validateXml                                Validates the XML files against the published schema"
   echo "      * checkFsPerms                               Checks the permissions, owner and group of the major CAF directories and files"
   echo ""
   echo "      * clearCaches                                Clears the CAF caches"
   echo "    args: The arguments to the command"
}

function validateXml() {
   local schemaArea="$1"
   local schemaPrefix="$2"
   validateNotEmpty "$schemaArea" "schemaArea"
   validateNotEmpty "$schemaPrefix" "schemaPrefix"

   setCafRootDir

   local schemaRoot="http://10.25.57.32/caf-downloads"

   for file in $(find "$CAF_OUTPUT_DIR" -name '*.xml' -print0 2>/dev/null | xargs -0 egrep -IH -lw "${schemaPrefix}.xsd"); do
      prtHeader "Validating $schemaArea/$schemaPrefix - $file"
      xmllint --schema "${schemaRoot}/schema/${schemaArea}/${schemaPrefix}.xsd" "$file"; rc=$?
      if [ "$rc" != "0" ]; then
         exit $rc
      fi
   done
}

function checkCerts() {
   setCafRootDir
   local certDir="$CAF_INPUT_DIR/certs"

   pushd $certDir > /dev/null

   prtHeader "Checking certs - $certDir"

   openssl rsa -in privateKey.pem -check -noout
   openssl verify -check_ss_sig -x509_strict -CAfile cacert.pem publicKey.pem

   local clientCertMd5=$(openssl x509 -noout -modulus -in publicKey.pem | openssl md5 | cut -d' ' -f2)
   local clientKeyMd5=$(openssl rsa -noout -modulus -in privateKey.pem | openssl md5 | cut -d' ' -f2)
   if [ "$clientCertMd5" == "$clientKeyMd5" ]; then
      echo "Public and Private Key md5's match"
   else
      echo "*** Public and Private Key md5's do not match"
      exit 1
   fi

   popd > /dev/null
}

function checkCertsVerbose() {
   setCafRootDir
   local certDir="$CAF_INPUT_DIR/certs"

   pushd $certDir > /dev/null

   prtHeader "Checking $certDir/cacert.pem"
   openssl x509 -in cacert.pem -text -noout

   prtHeader "Checking $certDir/publicKey.pem"
   openssl x509 -in publicKey.pem -text -noout

   prtHeader "Checking /etc/vmware-tools/GuestProxyData/server/cert.pem"
   openssl x509 -in /etc/vmware-tools/GuestProxyData/server/cert.pem -text -noout

   popd > /dev/null
}

function checkTunnel() {
   setCafRootDir
   local certDir="$CAF_INPUT_DIR/certs"

   pushd $certDir > /dev/null

   prtHeader "Connecting to tunnel"
   openssl s_client -connect localhost:6672 -key privateKey.pem -cert publicKey.pem -CAfile cacert.pem -verify 10

   popd > /dev/null
}

function checkFsPerms() {
   local dirOrFile="$1"
   local permExp="$2"
   local userExp="$3"
   local groupExp="$4"
   validateNotEmpty "$dirOrFile" "dirOrFile"
   validateNotEmpty "$permExp" "permExp"

   if [ "$userExp" = "" ]; then
      userExp="root"
   fi
   if [ "$groupExp" = "" ]; then
      groupExp="root"
   fi

   local statInfo=( $(stat -c "%a %U %G" $dirOrFile) )
   local permFnd=${statInfo[0]}
   local userFnd=${statInfo[1]}
   local groupFnd=${statInfo[2]}

   if [ "$permExp" != "$permFnd" ]; then
      echo "*** Perm check failed - expected: $permExp, found: $permFnd, dir/file: $dirOrFile"
      exit 1
   fi

   if [ "$userExp" != "$userFnd" ]; then
      echo "*** User check failed - expected: $userExp, found: $userFnd, dir/file: $dirOrFile"
      exit 1
   fi

   if [ "$groupExp" != "$groupFnd" ]; then
      echo "*** Group check failed - expected: $groupExp, found: $groupFnd, dir/file: $dirOrFile"
      exit 1
   fi
}

function clearCaches() {
   setCafRootDir

   validateNotEmpty "$CAF_OUTPUT_DIR" "CAF_OUTPUT_DIR"
   validateNotEmpty "$CAF_LOG_DIR" "CAF_LOG_DIR"

   prtHeader "Clearing the CAF caches"
   rm -rf \
      $CAF_OUTPUT_DIR/schemaCache/* \
      $CAF_OUTPUT_DIR/comm-wrk/* \
      $CAF_OUTPUT_DIR/providerHost/* \
      $CAF_OUTPUT_DIR/responses/* \
      $CAF_OUTPUT_DIR/requests/* \
      $CAF_OUTPUT_DIR/request_state/* \
      $CAF_OUTPUT_DIR/events/* \
      $CAF_OUTPUT_DIR/errorResponse.xml \
      $CAF_LOG_DIR/*
}

if [ $# -lt 1 -o "$1" = "--help" ]; then
   prtHelp
   exit 1
fi

cmd=$1
shift

case "$cmd" in
   "validateXml")
      validateXml "fx" "CafInstallRequest"
      validateXml "fx" "DiagRequest"
      validateXml "fx" "Message"
      validateXml "fx" "MgmtRequest"
      validateXml "fx" "MultiPmeMgmtRequest"
      validateXml "fx" "ProviderInfra"
      validateXml "fx" "ProviderRequest"
      validateXml "fx" "Response"
      validateXml "cmdl" "ProviderResults"
   ;;
   "checkCerts")
      checkCerts "$certDir"
   ;;
   "checkCertsVerbose")
      checkCertsVerbose "$certDir"
   ;;
   "checkTunnel")
      checkTunnel "$certDir"
   ;;
   "clearCaches")
      clearCaches
   ;;
   "enableCaf")
      enableCaf "$1" "$2"
   ;;
   "checkFsPerms")
      checkFsPerms "$CAF_INPUT_DIR" "755"
      checkFsPerms "$CAF_OUTPUT_DIR" "770"
      checkFsPerms "$CAF_CONFIG_DIR" "775"
      checkFsPerms "$CAF_LOG_DIR" "770"
      checkFsPerms "$CAF_BIN_DIR" "755"
      checkFsPerms "$CAF_LIB_DIR" "755"
   ;;
   *)
      echo "Bad command - $cmd"
      prtHelp
      exit 1
esac
