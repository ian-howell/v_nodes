FROM ubuntu:18.04

RUN apt-get update && apt-get install -y libvirt-daemon libvirt-bin libvirt-daemon-system libvirt-clients systemd

RUN find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \;
RUN systemctl set-default multi-user.target
RUN systemctl enable libvirtd
RUN systemctl enable virtlogd
COPY drop-ins/10-logs.conf /lib/systemd/system/libvirtd.service.d/10-logs.conf
COPY drop-ins/10-logs.conf /lib/systemd/system/virtlogd.service.d/10-logs.conf

RUN echo 'user = "root"' >> /etc/libvirt/qemu.conf
RUN echo 'group = "root"' >> /etc/libvirt/qemu.conf

ENTRYPOINT /bin/systemd
