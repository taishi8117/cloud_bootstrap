#!/bin/bash
set -e

BOLD='\033[0;1m'
NORMAL='\033[0m'

EMAIL=$(git config --global user.email)
KEYFILE=$HOME/.ssh/id_rsa.github
ADDKEY_URL="https://github.com/settings/ssh/new"

echo -e "[+] Creating Github ssh key for $EMAIL"
ssh-keygen -t rsa -b 4096 -C $EMAIL -f $KEYFILE -q -N ""
echo -e "[+] Created private/public key pair at ${BOLD}$KEYFILE${NORMAL}"

ssh-add $KEYFILE

echo -e "[+] Please visit ${BOLD}$ADDKEY_URL${NORMAL} and add the following key:"
cat "$KEYFILE.pub"
