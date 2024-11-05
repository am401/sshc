#!/bin/sh

# Read JSON config file
configfile=$(cat config.json | jq)

#index=$(echo $configfile | jq '.[] | index("AWS EC2")')
#sshname=$(cat $configfile | jq -r 'to_entries[] | .value.name' | fzf)
sshname=$(cat config.json | jq -r 'to_entries[] | .value.name' | fzf --border=rounded --margin=5% --prompt="Select SSH host > ")

index=$(cat config.json | jq --arg jq_sshname "${sshname}" 'to_entries[] | select(.value.name==$jq_sshname) | .key')

name=$(echo $configfile | jq -r --arg index "$index" '.[$index|tonumber] | .name')
user=$(echo $configfile | jq -r --arg index "$index" '.[$index|tonumber] | .user')
host=$(echo $configfile | jq -r --arg index "$index" '.[$index|tonumber] | .host')
port=$(echo $configfile | jq -r --arg index "$index" '.[$index|tonumber] | .port')
sshfile=$(echo $configfile | jq -r --arg index "$index" '.[$index|tonumber] | .sshfile')

echo "Connecting to ${name}"

if [[ $sshfile = "null" ]]
then
	ssh -p ${port} $user@$host
else
	ssh -p ${port} -i ${sshfile} $user@$host
fi	
