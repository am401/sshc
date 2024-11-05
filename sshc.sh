#!/bin/sh

# Read JSON config file
configfile=$(<config.json)

sshname=$(jq -r 'to_entries[] | .value.name' <<< "$configfile" | fzf)

index=$(jq --arg jq_sshname "${sshname}" 'to_entries[] | select(.value.name==$jq_sshname) | .key' <<< "$configfile")

name=$(jq -r --arg index "$index" '.[$index|tonumber] | .name' <<< $configfile)
user=$(jq -r --arg index "$index" '.[$index|tonumber] | .user' <<< $configfile)
host=$(jq -r --arg index "$index" '.[$index|tonumber] | .host' <<< $configfile)
port=$(jq -r --arg index "$index" '.[$index|tonumber] | .port' <<< $configfile)
sshfile=$(jq -r --arg index "$index" '.[$index|tonumber] | .sshfile' <<< $configfile)

echo "Connecting to ${name}"

if [[ $sshfile = "null" ]]
then
	ssh -p ${port} $user@$host
else
	ssh -p ${port} -i ${sshfile} $user@$host
fi	
