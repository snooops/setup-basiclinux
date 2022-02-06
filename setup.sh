#!/bin/bash


# setting hostname
ipaddress=$(ip a |grep eth0 |grep inet | cut -d' ' -f 6 | cut -d '/' -f 1)
newhostname=$(grep $ipaddress inventory.ini |cut -d ' ' -f1)

if [ ! -z $newhostname ];
then
        echo $newhostname | sudo tee /etc/hostname
else
        echo "no hostname found, skipping"
fi

# installing packages
sudo apt update
sudo apt install vim zsh git htop sysstat curl ca-certificates -y

# setting timezone
sudo timedatectl set-timezone Europe/Berlin

# installing vim config
curl https://raw.githubusercontent.com/snooops/vimrc/main/install-my-vimrc.sh | sh -

# setting vim config default for new and root user
sudo cp ~/.vimrc /etc/skel/
sudo cp ~/.vimrc /root/

# adding admin user
sudo useradd -m snooops -s /bin/zsh -G sudoers

# removing pi user
sudo userdel pi -rf
