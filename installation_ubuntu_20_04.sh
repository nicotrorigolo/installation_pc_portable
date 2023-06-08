echo "L'installation de la configuration est effectué sur Ubuntu 20.04 LTS"

#Commande pour ne pas rentrer le mot de passe sudo
#echo {mot_de_passe} | sudo -S apt install {paquet}

echo "Mettre a jour python"
sudo add-apt-repository -y ppa:deadsnakes/ppa \
&& sudo apt -y update \
&& sudo apt -y install python3.11

echo "Installer les packages d'installations"
sudo apt install -y wget gpg apt-transport-https git nano curl python3.11-venv virtualbox net-tools tree

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
# Suite a une evolution de version de vagrant, il faut declarer les adresses ip que l'on souhaite creer
sudo mkdir /etc/vbox/ \
&& sudo echo * 10.0.0.0/20 > /etc/vbox/networks.conf

echo "Installation de docker"
sudo apt install -y docker.io
sudo usermod -aG docker $USER

echo "Installation de docker-compose"
sudo apt install -y docker-compose

echo "Installer nodeJS"
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
&& sudo apt-get install -y nodejs

echo "Installer l'environnement virtuel python"
mkdir ~/venv \
&& python3.11 -m venv ~/venv

echo "Installer Ansible"
# Il existe plein de manières d'installer Ansible, toutefois l'installation via python est la plus simple
source ~/venv/bin/activate
pip install ansible \
&& ansible-lint # linter de ansible, c'est facultatif
# Pour pouvoir se connecter en ssh avec ansible, il faut installer le packet suivant. La connexion en ssh va fonctionner avec l'argument "-k".
sudo apt install sshpass
# Creation du fichier de ansible.cfg #Avec une installation via pip, ansible ne crée pas le fichier ansible.cfg
sudo mkdir /etc/ansible \
&& echo host_key_checking = False > ansible.cfg \
&& sudo mv ansible.cfg /etc/ansible/ansible.cfg

echo "Installation robotframework"
pip install robotframework \
&& robotframework-debuglibrary \
&& robotframework-browser
rfbrowser init

echo "Installer glab" #La commande pour l'installation de glab ne peut pas etre effectue par "root".
sudo apt install -y build-essential \
&& NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
&& (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/$USER/.bashrc \
&& eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
&& brew install glab \
&& eval "$(glab completion -s bash)"  # auto-completion de glab

echo "Fin des installations"
echo "Redemarrer le PC pour pouvoir initialiser docker"
