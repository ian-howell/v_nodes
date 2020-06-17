#!/bin/bash
set -ex

a2enmod headers ssl
a2enconf ssl-params

groupadd libvirt
useradd -g libvirt -M -d /var/lib/libvirt -c "apache sushy user" sushy 
mkdir -p /var/www/sushy-emulator

openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/private/airship_gate_redfish_auth.key -x509 -days 365 -out /etc/ssl/certs/airship_gate_redfish_auth.pem -config <( cat /opt/conf/csr_details.txt ) -extensions 'req_ext'

htpasswd -bc /etc/apache2/sites-available/airship_gate_redfish_auth.htpasswd username password

mkdir -p /home/sushy
chown -R sushy /home/sushy

source /etc/apache2/envvars
tail -f /dev/null
apache2 -DFOREGROUND
