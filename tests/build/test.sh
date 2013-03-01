#!/bin/bash

set -e

CYAN="\033[00;36m"
GREEN="\033[00;32m"
PURPLE="\033[00;35m"
RED="\033[00;31m"
WHITE="\033[00m"
YELLOW="\033[00;33m"

# Make sure script is run with root privileges
if [ ! $UID -eq 0 ] ; then
    echo -e "${RED}Script must be run as root${WHITE}"
    exit
fi

SCRIPT_LOCATION=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
MODULE_DIR="/etc/puppet/modules/composer"

# Link build module
if [ ! -L "${MODULE_DIR}" ]; then
    ln -s "${SCRIPT_LOCATION}/../../" "${MODULE_DIR}"
fi

# Run test install
puppet apply "${SCRIPT_LOCATION}/../test.pp"
