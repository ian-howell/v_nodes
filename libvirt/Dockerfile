FROM ubuntu:18.04

RUN apt-get update && apt-get install -y libvirt-daemon libvirt-bin libvirt-daemon-system libvirt-clients
COPY entrypoint.sh /var/tmp/entrypoint.sh

RUN echo 'stdio_handler="file"' >> /etc/libvirt/qemu.conf
RUN echo 'user = "root"' >> /etc/libvirt/qemu.conf
RUN echo 'group = "root"' >> /etc/libvirt/qemu.conf

RUN chmod +x /var/tmp/entrypoint.sh && ls -ltr /var/tmp/entrypoint.sh

CMD /var/tmp/entrypoint.sh
