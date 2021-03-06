#!/bin/bash
# deploy_tar.sh - Made for Puppi
# This script deploys a (tar) file from the download dir (storedir) to the deployroot (given as $1)
# To refer to the name of the file to deploy it uses the value of the variable named in $2 
# The name of the variable is generally found in the project runtime configuration files.

configfile="/etc/puppi/puppi.conf"

# Load general configurations
if [ ! -f $configfile ] ; then
    echo "Config file: $configfile not found"
    exit 1
else
    . $configfile
    . $scriptsdir/functions
fi

# Load project runtime configuration
projectconfigfile="$workdir/$project/config"
if [ ! -f $projectconfigfile ] ; then
    echo "Project runtime config file: $projectconfigfile not found"
    exit 1
else
    . $projectconfigfile
fi

if [ $1 ] ; then
    deployroot=$1
else
    echo "You must provide a directory name!"
    exit 2 
fi

# Obtain the value of the variable with name passed as second argument
deployfilevar=""
if [ $2 ] ; then
    deployfilevar=$2
fi
deployfile="$(eval "echo \${$(echo ${deployfilevar})}")"

# Untar  file
move () {
    cd $deployroot
    tar -xvf $storedir/$deployfile
}

move
