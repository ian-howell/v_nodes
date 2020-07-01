FROM vairship/base:latest

SHELL ["bash", "-exc"]
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update ;\
    apt-get dist-upgrade -y ;\
    apt-get install -y \
        apache2 \
        git \
        python3 \
        libapache2-mod-wsgi-py3 \
        python3-passlib \
        libvirt-clients ;\
    rm -rf /var/lib/apt/lists/* ;\
    pip3 install --upgrade git+https://github.com/dukov/sushy-tools.git@0.9.1 ;\
    rm -rf /var/lib/apt/lists/* ;\
    groupadd -g 108 libvirt || true ;\
    useradd -u 42424 -g 108 -M -d /home/sushy -c "apache sushy user" sushy ;\
    mkdir -p /home/sushy ;\
    chown -R sushy /home/sushy ;\
    mkdir -p /var/www/sushy-emulator

COPY assets /opt/assets/
RUN cp -ravf /opt/assets/* / ;\
    rm -rf /opt/assets

RUN a2enmod headers ssl
RUN a2enconf ssl-params

ENTRYPOINT /entrypoint.sh




#curl --insecure https://username:password@127.0.0.1:8443/redfish/v1/Systems/

# curl -L -u "username:password" --insecure  -d '{"ResetType":"ForceOff"}' \
# -H "Content-Type: application/json" -X POST \
# https://127.0.0.1:8443/redfish/v1/Systems/airshipdev-1/Actions/ComputerSystem.Reset