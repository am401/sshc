#!/bin/sh

# Read JSON config file
if [ -f config.json ]; then
	configfile=$(<config.json)
else
	echo "config.json file does not exist. Please ensure it's in the same directory and configured before running this script."
	exit 1
fi

sshname=$(jq -r 'to_entries[] | .value.name' <<< "$configfile" | fzf --border=rounded --margin=5% --prompt="Select SSH connection > ")

index=$(jq --arg jq_sshname "${sshname}" 'to_entries[] | select(.value.name==$jq_sshname) | .key' <<< "$configfile")

if [ -z $index ]; then
	echo "SSH connection entered could not be found. Please select a valid connection."
	exit 1
fi 

name=$(jq -r --arg index "$index" '.[$index|tonumber] | .name' <<< $configfile)
user=$(jq -r --arg index "$index" '.[$index|tonumber] | .user' <<< $configfile)
host=$(jq -r --arg index "$index" '.[$index|tonumber] | .host' <<< $configfile)
port=$(jq -r --arg index "$index" '.[$index|tonumber] | .port' <<< $configfile)
identityfile=$(jq -r --arg index "$index" '.[$index|tonumber] | .sshfile' <<< $configfile)

echo "Connecting to ${name}"

if [[ $identityfile = "null" ]]
then
	ssh -p ${port} $user@$host
else
	ssh -p ${port} -i ${identityfile} $user@$host
fi	
