FROM ianhowell/base:test

SHELL ["bash", "-exc"]
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update ;\
    apt-get dist-upgrade -y ;\
    apt-get install -y \
            libvirt-daemon \
            qemu-kvm \
            libvirt-daemon-system \
            bridge-utils \
            libvirt-clients \
            systemd \
            socat ;\
    find /etc/systemd/system \
         /usr/lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \; ;\
    systemctl set-default multi-user.target ;\
    sed -i 's|SocketMode=0660|SocketMode=0666|g' /lib/systemd/system/libvirtd.socket ;\
    systemctl enable libvirtd ;\
    systemctl enable virtlogd ;\
    echo 'user = "root"' >> /etc/libvirt/qemu.conf ;\
    echo 'group = "root"' >> /etc/libvirt/qemu.conf ;\
    sed -i 's|unix_sock_rw_perms = "0770"|unix_sock_rw_perms = "0777"|g' /etc/libvirt/libvirtd.conf ;\
    useradd -u 42424 -g libvirt -M -d /home/sushy -c "apache sushy user" sushy ;\
    mkdir -p /home/sushy ;\
    chown -R sushy /home/sushy

COPY assets /opt/assets/
RUN cp -ravf /opt/assets/* / ;\
    rm -rf /opt/assets

ENTRYPOINT /bin/systemd
