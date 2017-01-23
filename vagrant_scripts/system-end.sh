#!/bin/bash

#
#  Cleanup
#
apt-get autoremove -y
apt-get autoclean -y

echo -e "----------------------------------------"
echo -e "To edit this project:\n"
echo -e "----------------------------------------"
echo -e "$ cd /vagrant/source"
echo -e
echo -e "----------------------------------------"
echo -e "http://magento1.local/ (192.168.80.80)"
echo -e "----------------------------------------"

