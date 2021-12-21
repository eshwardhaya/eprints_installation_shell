#!bin/bash

# Update System
apt-get update && apt-get upgrade -y

# Installing Apache Server
apt-get install expect apache2 -y

# Enable Perl on Apache
a2enmod perl

# Restart Apache
systemctl restart apache2.service

# Add Eprint Sources
echo "deb http://deb.eprints-hosting.org/3.4/stable/ ./" > /etc/apt/sources.list.d/eprints.list

# Add Eprints Signature
wget -O - http://deb.eprints-hosting.org/keyFile | apt-key add -

# Update System 
apt-get update && apt-get upgrade -y

# Install XPDF 
wget http://security.ubuntu.com/ubuntu/pool/main/p/poppler/libpoppler73_0.62.0-2ubuntu2.12_amd64.deb

dpkg -i xpdf_3.04-7_amd64.deb 

apt install --fix-broken -y

# Install libPopper
wget http://archive.ubuntu.com/ubuntu/pool/universe/x/xpdf/xpdf_3.04-7_amd64.deb

dpkg -i xpdf_3.04-7_amd64.deb

apt install --fix-broken -y

# Install Eprints
apt install eprints -y	

# Download Flavours
wget https://files.eprints.org/2500/8/eprints-3.4.2-flavours.tar.gz

tar -xzvf eprints-3.4.2-flavours.tar.gz

mv eprints-3.4.2/flavours/pub_lib /usr/share/eprints/flavours

chmod -R g+w /usr/share/eprints/flavours/pub_lib

chown -R eprints:eprints /usr/share/eprints/flavours/pub_lib

# Configure Eprints
su -l eprints -c "./bin/epadmin create pub"

# Cleaning Up
rm -rf * *.tar.gz *.deb

