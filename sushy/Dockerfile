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
        python3-setuptools \
        libvirt-clients ; \
    pip3 install --upgrade sushy ;\
    pip3 install --upgrade sushy-tools ;\
    rm -rf /var/lib/apt/lists/* ;\
    groupadd -g 108 libvirt ;\
    useradd -u 42424 -g libvirt -M -d /home/sushy -c "apache sushy user" sushy ;\
    mkdir -p /home/sushy ;\
    chown -R sushy /home/sushy ;\
    mkdir -p /var/www/sushy-emulator

COPY assets /opt/assets/
RUN cp -ravf /opt/assets/* / ;\
    rm -rf /opt/assets

RUN a2enmod headers ssl
RUN a2enconf ssl-params

CMD /entrypoint.sh




#curl --insecure https://username:password@127.0.0.1:8443/redfish/v1/Systems/

# curl --insecure  -d '{"ResetType":"ForceOff"}' \
# -H "Content-Type: application/json" -X POST \
# https://username:password@127.0.0.1:8443/redfish/v1/Systems/90f40218-5faa-4d34-a30d-eb40673e6d23/Actions/ComputerSystem.Reset