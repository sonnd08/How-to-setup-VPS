# Quick script to setup swap for vps and basic pakages
# nginx, git, npm, yarn, npx, pm2

# to run this script copy this file than using this script
# sudo chmod 777 ./install-basic-package.sh && sudo ./install-basic-package.sh
# or just paste content of this file to VPS console

# prevent bash save dupllicated script or start by whitespace
echo "HISTCONTROL=ignoreboth" >>~/.bashrc

#sudo apt install expect -y

sudo apt update

# Setup swap 
# base on this guide https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-16-04
sudo swapon --show
free -h
# sudo fallocate -l <Should be Your ram x 2> /swapfile
sudo fallocate -l 3G /swapfile
ls -lh /swapfile
sudo chmod 600 /swapfile
ls -lh /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
free -h

sudo cp /etc/fstab /etc/fstab.bak
sudo echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab


# utilizing swap
cat /proc/sys/vm/swappiness
sudo sysctl vm.swappiness=10
cat /proc/sys/vm/vfs_cache_pressure
sudo sysctl vm.vfs_cache_pressure=50
sudo echo 'vm.swappiness=10' >>  /etc/sysctl.conf
sudo echo 'vm.vfs_cache_pressure=50' >>  /etc/sysctl.conf



#install nodejs, nginx, git, npm, npx, pm2 and yarn
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

apt-get install git-core -y
git --version
#git config --global user.name "Son Nguyen"
#git config --global user.email "sonnd08@gmail.com"

apt install npm -y
npm install -g npx
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn -y
yarn --version

npm install pm2 -g
# limit log size for pm2 (to prevent runing out of disk due to too many logs created)
pm2 install pm2-logrotate
# limit log size to 1Gb
pm2 set pm2-logrotate:max_size 1G 
pm2 set pm2-logrotate:compress true


#install nginx 
sudo apt install nginx -y
sudo ufw allow 'Nginx HTTP'
sudo ufw status
