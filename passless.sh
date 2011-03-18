#! /usr/bin/env bash
#######
# Configures password-less login on remote SSH servers
# Usage: passless.sh <user> <server> [<port>]
# Port is optional - defaults to 22.
echo "This script walks through setting up passwordless login on remote SSH servers. You'll be required to enter your password in steps 2 and 3."
MINPARAMS=2
if [ $# -eq "0" ]
then
    echo "Usage: passless.sh <user> <server> [<port>]"
    exit 2
elif [ $# -lt "$MINPARAMS" ]
then
  echo "This script needs at least $MINPARAMS command-line arguments!"
  echo "Usage: passless.sh <user> <server> [<port>]"
  exit 2
fi
USER=$1
SERVER=$2
PORT=""
if [[ "${3}" -ne "" ]]
then 
echo "Using port ${3}..."
PORT="-p ${3}"
fi
echo "Step 1: Generating RSA Key - Accept the default location & don't enter a password."
if [ -f ~/.ssh/id_rsa ]
then
echo "RSA Key already exists."
else
ssh-keygen -t rsa
fi
echo "Step 2: Creating the .ssh directory on the remote server."
ssh ${PORT} ${USER}@${SERVER} 'mkdir -p ~/.ssh'
echo "Step 3: Copying the ssh key to the remote server."
cat ~/.ssh/id_rsa.pub | ssh ${PORT} ${USER}@${SERVER} 'cat >> ~/.ssh/authorized_keys'
echo "Done! You should be able to log in now."
