#!/bin/bash
##########################
#GLOBAL VARS
###########################
PYTHON_VERSION="2.7.10"
ACESS_KEY="EXAMPLE"

aws_cli_install () {
sudo apt update
sudo apt install python3.6
mkdir python
cd python
wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
tar -zxvf Python-$PYTHON_VERSION.tgz
sudo apt install build-essential checkinstall -y
sudo apt install libreadline-gplv2-dev libncursesw5-dev libgdbm-dev libc6-dev libbz2-dev libsqlite3-dev tk-dev libssl-dev -y
cd Python-$PYTHON_VERSION
sudo ./configure
sudo make altinstall
whereis python2.7
python2.7 --version
sudo apt install python-pip python-dev build-essential -y
pip install --upgrade pip
sudo pip install --upgrade virtualenv
pip install awscli --upgrade --user
aws --version
pip install awscli --upgrade --user
}

git_install () {
sudo apt install git -y
}

config () {
cat <<"EOF">> config
Host git-codecommit.*.amazonaws.com
User $ACESS_KEY
IdentityFile ~/.ssh/id_rsa
EOF
}

ssh_key_conf () {
sudo apt update && sudo apt upgrade -y
ssh localhost true
cd .ssh
ssh-keygen -t rsa -b 4096 -f id_rsa -N ''
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
cp ~/.ssh/authorized_keys ~/.ssh/authorized_keys_Backup
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
echo 'restarting SSH Deamon'
systemctl restart ssh
config
}

cat << EOF 
##################################################
This script is desighned to help in aiding 
to get started with the VCS system AWS codecommit
##################################################
EOF
sleep 2

#aws_cli_install
ssh_key_conf
git_install
