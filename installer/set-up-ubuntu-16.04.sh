#!/bin/bash

apt-get -y install git
if [ ! -d ./mptcp ]
then 
git clone -b mptcp_v0.92 https://github.com/MPSec/mptcp.git
echo "No file"
else
echo "File exist! skip download!"
fi
apt-get -y install build-essential libncurses5 libncurses5-dev bin86 kernel-package libssl-dev
cd ./mptcp
make mrproper
cp -rv --preserve=timestamps ../config-4.4.110+.txt .config
echo "Finish Auto Make Menuconfig"
make -j 6
make modules_install
make install
cp -rv --preserve=timestamps ../ubuntu-16.04-grup.txt /etc/default/grub
echo "Finish Auto Grub Select"
update-grub
# reboot
# dmesg | grep MPTCP # Check MPTCP
