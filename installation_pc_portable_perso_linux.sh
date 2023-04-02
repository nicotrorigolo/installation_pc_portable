#!/bin/bash

echo "Donner acces a l'utilisateur"
sudo chmod o+rx /home/$USER

echo "Installer package d'installation"
sudo apt install -y wget git nano curl

echo "Installer google chrome"
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
&& apt-get install -y ./google-chrome-stable_current_amd64.deb

echo "Installer vscode"
sudo apt install -y code

echo "Installer vagrant"
sudo apt install -y vagrant

echo "Installation de docker"
sudo apt update
sudo apt install -y docker.io
sudo usermod -aG docker $USER
