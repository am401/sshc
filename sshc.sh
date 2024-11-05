#!/bin/sh

# Read JSON config file
#configfile=$(cat config.json | jq)


#index=$(echo $configfile | jq '.[] | index("AWS EC2")')
#sshname=$(cat $configfile | jq -r 'to_entries[] | .value.name' | fzf)
sshname=$(cat config.json | jq -r 'to_entries[] | .value.name' | fzf < /dev/tty > /dev/tty)
index=$(cat config.json | jq --arg sshname "$sshname" 'to_entries| .[] | select(.value.name=="$sshname") | .key')

echo $index

name=$(echo $configfile | jq -r --arg index "$index" '.[$index] | .name')
user=$(echo $configfile | jq -r --arg index "$index" '.[$index] | .user')
host=$(echo $configfile | jq -r --arg index "$index" '.[$index] | .host')
port=$(echo $configfile | jq -r --arg index "$index" '.[$index] | .port')
sshfile=$(echo $configfile | jq -r --arg index "$index" '.[$index] | .sshfile')

echo $name
echo $user
echo $host
echo $port
echo $sshfile

echo "Connecting to ${name}"

if [[ $sshfile = "null" ]]
then
	ssh -p ${port} $user@$host
else
	ssh -p ${port} -i ${sshfile} $user@$host
fi	
