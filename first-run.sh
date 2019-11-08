#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "1.UPDATING AND REMOVING" &&
echo -e "----------------------------${NC}" &&
echo "" &&

sudo apt-get update &&
sudo apt-get upgrade -y &&
sudo apt-get install htop npm &&
sudo npm cache clean -f &&
sudo npm install -g n &&
sudo n stable &&

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "2.CREATING SWAP" &&
echo -e "----------------------------${NC}" &&
echo "" &&

sudo swapoff -a
sudo fallocate -l 2G /swapfile &&
sudo chmod 600 /swapfile &&
sudo mkswap /swapfile &&
sudo swapon /swapfile &&
sudo cp /etc/fstab /etc/fstab.bak &&
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab &&

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "3.VISUAL STUDIO CODE CONFIGURATIONS" &&
echo -e "----------------------------${NC}" &&
echo "" &&

echo fs.inotify.max_user_watches=250000 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p &&

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "4.UPDATING BITNAMI" &&
echo -e "----------------------------${NC}" &&
echo "" &&

sudo /opt/bitnami/ctlscript.sh stop &&
sudo rm -rf /opt/bitnami &&
cd &&
wget https://bitnami.com/redirect/to/770107/bitnami-lampstack-7.3.11-0-linux-x64-installer.run &&
sudo chmod u+x bitnami-lampstack-7.3.11-0-linux-x64-installer.run &&
sudo ./bitnami-lampstack-7.3.11-0-linux-x64-installer.run &&
cat bitnami-lamp.sh | sudo tee /etc/init.d/bitnami &&

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "5.CLEANING" &&
echo -e "----------------------------${NC}" &&
echo "" &&

sudo apt-get autoclean -y
sudo apt-get autoremove -y

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "DONE, REBOOTING IN 10 SECONDS" &&
echo -e "----------------------------${NC}" &&
echo ""

for pc in $(seq 1 10); do
    echo -ne "${RED}."
    sleep 1
done

sudo reboot

