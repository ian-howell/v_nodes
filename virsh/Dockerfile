FROM vairship/base:latest

SHELL ["bash", "-exc"]
ENV DEBIAN_FRONTEND noninteractive

# Update distro and install ansible
RUN apt-get update ;\
    apt-get dist-upgrade -y ;\
    apt-get install -y \
        python3-minimal \
        python3-pip \
        python3-apt \
        python3-lxml \
        python3-libvirt \
        virtinst \
        nfs4-acl-tools \
        acl \
        bridge-utils \
        python3-setuptools \
        virt-manager \
        openssh-client ;\
    pip3 install --upgrade wheel ;\
    pip3 install --upgrade ansible ;\
    rm -rf /var/lib/apt/lists/*

COPY assets /opt/assets/
RUN cp -ravf /opt/assets/* / ;\
    rm -rf /opt/assets

ENTRYPOINT /entrypoint.sh
