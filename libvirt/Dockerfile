FROM ubuntu:20.04

RUN apt-get update && apt-get install -y libvirt-daemon qemu-kvm libvirt-daemon-system libvirt-clients systemd

RUN find /etc/systemd/system \
         /usr/lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \; ;\
    systemctl set-default multi-user.target ;\
    systemctl enable libvirtd ;\
    systemctl enable virtlogd ;\
    echo 'user = "root"' >> /etc/libvirt/qemu.conf ;\
    echo 'group = "root"' >> /etc/libvirt/qemu.conf ;\
    sed -i 's|unix_sock_rw_perms = "0770"|unix_sock_rw_perms = "0777"|g' /etc/libvirt/libvirtd.conf ;\
    useradd -u 42424 -g libvirt -M -d /home/sushy -c "apache sushy user" sushy ;\
    mkdir -p /home/sushy ;\
    chown -R sushy /home/sushy

COPY assets /opt/assets/
RUN echo hey ;\
    cp -ravf /opt/assets/* / ;\
    rm -rf /opt/assets

ENTRYPOINT /bin/systemd
