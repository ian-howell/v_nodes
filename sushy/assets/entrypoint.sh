#!/bin/bash
set -ex
#tail -f /dev/null

openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/private/airship_gate_redfish_auth.key -x509 -days 365 -out /etc/ssl/certs/airship_gate_redfish_auth.pem -config <( cat /opt/conf/csr_details.txt ) -extensions 'req_ext'

htpasswd -bc /etc/apache2/sites-available/airship_gate_redfish_auth.htpasswd username password

source /etc/apache2/envvars
mkdir -p $APACHE_RUN_DIR

exec apache2 -DFOREGROUND
