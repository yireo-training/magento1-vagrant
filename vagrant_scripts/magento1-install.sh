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

ln -s /tmp var

#
# Magento 1 setup
#

# Versions are defined in n98-magerun.yml (see above)
version="yireo-magento-ce-1.9.3.1"
baseUrl="http://magento1.local/"

# Run installation
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

# Copy XML configuration (Redis)
cp /vagrant/vagrant_files/app-etc-local.xml app/etc/local.xml

# Install some extensions optionally
cp /vagrant/magento_extensions/*.zip .
for i in *.zip ; do
    unzip -q $i
    rm $i
done

cp /vagrant/magento_extensions/*.tar.gz .
for i in *.tar.gz ; do
    tar -xzf $i
    rm $i
done

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
