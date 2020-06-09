FROM ubuntu:20.04

SHELL ["bash", "-exc"]
ENV DEBIAN_FRONTEND noninteractive

# Update distro and install ansible
RUN apt-get update ;\
    apt-get dist-upgrade -y ;\
    apt-get install -y \
        python3-minimal \
        python3-pip \
        python3-apt \
        virtinst \
        bridge-utils \
        python3-setuptools \
        virt-manager \
        openssh-client ;\
    pip3 install --upgrade wheel ;\
    pip3 install --upgrade ansible ;\
    rm -rf /var/lib/apt/lists/*

COPY ansible /opt/ansible

RUN chmod +x /opt/ansible/entrypoint.sh && ls -ltr /opt/ansible/entrypoint.sh

CMD /opt/ansible/entrypoint.sh
