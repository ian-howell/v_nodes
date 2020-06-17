FROM ubuntu:20.04

SHELL ["bash", "-exc"]
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update ;\
    apt-get dist-upgrade -y ;\
    apt-get install -y \
        apache2 \
        python3-minimal \
        python3-pip \
        python3-apt \
        python3-libvirt \
        libapache2-mod-wsgi-py3 \
        python3-passlib \
        python3-openssl \
        curl \
        python3-setuptools; \
    pip3 install --upgrade sushy ;\
    pip3 install --upgrade sushy-tools ;\
    rm -rf /var/lib/apt/lists/*


COPY apache2/airship_gate_redfish_auth-ssl.conf /etc/apache2/mods-enabled/airship_gate_redfish_auth-ssl.conf
COPY apache2/airship_gate_redfish_auth.conf  /etc/apache2/sites-enabled/airship_gate_redfish_auth.conf
COPY apache2/csr_details.txt  /opt/conf/csr_details.txt 
COPY apache2/sushy-emulator.wsgi /var/www/sushy-emulator/sushy-emulator.wsgi
COPY apache2/ssl-params.conf /etc/apache2/conf-available/ssl-params.conf
COPY entrypoint.sh /opt/bin/entrypoint.sh

RUN chmod +x /opt/bin/entrypoint.sh && ls -ltr /opt/bin/entrypoint.sh

CMD /opt/bin/entrypoint.sh
