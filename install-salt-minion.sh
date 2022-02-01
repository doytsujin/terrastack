echo 'deb http://httpredir.debian.org/debian jessie-backports main' >> sudo /etc/apt/sources.list
echo 'deb http://httpredir.debian.org/debian stretch main' >> sudo /etc/apt/sources.list
echo 'APT::Default-Release "jessie";' > sudo /etc/apt/apt.conf.d/10apt
sudo apt update
sudo apt-get install python3 salt-common vim -y
sudo apt-get install salt-minion -y