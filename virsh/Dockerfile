FROM ubuntu:20.04

SHELL ["bash", "-exc"]
ENV DEBIAN_FRONTEND noninteractive

# Update distro and install ansible
RUN apt-get update ;\
    apt-get dist-upgrade -y ;\
    apt-get install -y --no-install-recommends \
        python3-minimal \
        python3-pip \
        python3-apt \
        rand \
        virtinst \
        python3-setuptools \
        virt-manager \
        openssh-client ;\
    pip3 install --upgrade wheel ;\
    pip3 install --upgrade ansible ;\
    rm -rf /var/lib/apt/lists/*

RUN echo 'user = "root"' >> /etc/libvirt/qemu.conf
RUN echo 'group = "root"' >> /etc/libvirt/qemu.conf
COPY assets /opt/assets

CMD /opt/assets/entrypoint.sh

RUN chmod +x /opt/assets/entrypoint.sh && ls -ltr /opt/assets/entrypoint.sh

ENTRYPOINT [ "/var/assets/entrypoint.sh" ]

CMD ["create_nodes"]
