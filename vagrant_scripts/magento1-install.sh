#!/bin/bash
#
# Composer
#
composer global require --no-progress "hirak/prestissimo:^0.3"
mkdir -p ~/.composer

test -f /vagrant/vagrant_files/composer-auth.json && cp /vagrant/vagrant_files/composer-auth.json ~/.composer/auth.json

# Magerun setup
cp /vagrant/vagrant_files/n98-magerun.yaml ~/.n98-magerun.yaml

#
mkdir /vagrant/source
cd /vagrant/source

mkdir /tmp/magento-var
ln -s /tmp/magento-var var

#
# Magento 1 setup
#
version="yireo-magento-ce-1.9.3.1"
baseUrl="http://magento1.local/"
php -d memory_limit=1G /usr/local/bin/magerun install \
    --dbHost="localhost" \
    --dbUser="root" \
    --dbPass="root" \
    --dbName="magento1" \
    --installSampleData=yes \
    --useDefaultConfigParams=yes \
    --magentoVersionByName=$version \
    --installationFolder="/vagrant/source" \
    --baseUrl=$baseUrl

cp /vagrant/vagrant_files/app-etc-local.xml app/etc/local.xml

#
# Install Inchoo_PHP7
#
mkdir tmp/
cd tmp/
wget -q https://github.com/Inchoo/Inchoo_PHP7/archive/2.0.0.zip
unzip -q 2.0.0.zip
cp -R Inchoo_PHP7-2.0.0/app ../
cd -
rm -r tmp/

# Finalize
magerun cache:flush

# End
