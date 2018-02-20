#!/bin/bash
aws_cli_install () {
sudo apt-get update
sudo apt-get install python3.6
mkdir python
cd python
wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
tar -zxvf Python-2.7.10.tgz
sudo apt-get install build-essential checkinstall -y
sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libgdbm-dev libc6-dev libbz2-dev libsqlite3-dev tk-dev libssl-dev -y
cd Python-2.7.10
sudo ./configure
sudo make altinstall
whereis python2.7
python2.7 --version
sudo apt-get install python-pip python-dev build-essential -y
pip install --upgrade pip
sudo pip install --upgrade virtualenv
pip install awscli --upgrade --user
aws --version
pip install awscli --upgrade --user
}

git_install () {
sudo apt-get install git -y
}

config () {
cat &lt;&lt; EOF &gt;&gt; config
Host git-codecommit.*.amazonaws.com
User APKAEIBAERJR2EXAMPLE
IdentityFile ~/.ssh/id_rsa
EOF
}

ssh_key_conf () {
sudo apt-get update &amp;&amp; sudo apt-get upgrade -y
ssh localhost true
cd .ssh
ssh-keygen -t rsa -b 4096 -f id_rsa -N ''
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
cp ~/.ssh/authorized_keys ~/.ssh/authorized_keys_Backup
cat ~/.ssh/id_rsa.pub &gt;&gt; ~/.ssh/authorized_keys
echo 'restarting SSH Deamon'
sudo service ssh restart
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