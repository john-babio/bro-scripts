#!/bin/bash
sudo apt-get -y install wget build-essential cmake make gcc g++ flex bison libpcap-dev libssl-dev python-dev swig zlib1g-dev libmagic-dev

wget -O/tmp/bro-2.4.tar.gz https://www.bro.org/downloads/release/bro-2.4.tar.gz

cd /tmp
tar -xvf bro-2.4.tar.gz
cd /tmp/bro-2.4
sudo ./configure && sudo make && sudo make install

sudo sed -i 's/interface=eth0/interface=eth1/g' /usr/local/bro/etc/node.cfg 

sudo ifconfig eth1 0.0.0.0 up promisc

sudo /usr/local/bro/bin/broctl install
sudo /usr/local/bro/bin/broctl start




