#!/bin/bash

BOLD='\033[0;1m'
NORMAL='\033[0m'
if [ "$#" -ne 1  ]; then
  echo "[Usage] $0 <hostname>"
  exit
fi

HOSTNAME=$1
echo -e "Change hostname to ${BOLD}$HOSTNAME${NORMAL}"

sudo sed -i 's/preserve_hostname: false/preserve_hostname: true/g' /etc/cloud/cloud.cfg
cat /etc/cloud/cloud.cfg | grep "preserve_hostname"

sudo hostname $HOSTNAME
echo $1 | sudo tee /etc/hostname > /dev/null
echo "Changed hostname successfully."

while true; do
  read -p "Reboot now? (y/n) " yn
  case $yn in
    [Yy]* ) sudo reboot;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
  esac
done
