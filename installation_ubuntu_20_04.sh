echo "L'installation de la configuration est effectué sur Ubuntu 20.04 LTS"

#Commande pour ne pas rentrer le mot de passe sudo
#echo {mot_de_passe} | sudo -S apt install {paquet}

echo "Installer les packages d'installations"
sudo apt install -y wget gpg apt-transport-https git nano curl python3.8-venv virtualbox net-tools

echo "Installer google chrome"
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
&& sudo apt-get install -y ./google-chrome-stable_current_amd64.deb \
&& rm -f google-chrome-stable_current_amd64.deb

echo "Installer vscode"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
&& sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
&& sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
&& rm -f packages.microsoft.gpg \
&& sudo apt update \
&& sudo apt install -y code

echo "Installer vagrant"
sudo apt install -y vagrant

echo "Installation de docker"
sudo apt install -y docker.io
sudo usermod -aG docker $USER

echo "Installer nodeJS"
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
&& sudo apt-get install -y nodejs

echo "Installer l'environnement virtuel python"
mkdir ~/venv \
&& python3 -m venv ~/venv \

echo "Installer Ansible"
# Il existe plein de manières d'installer Ansible, toutefois l'installation via python est la plus simple
source ~/venv/bin/activate
pip install ansible

echo "Fin des installations"
echo "Redemarrer le PC pour pouvoir initialiser docker"
