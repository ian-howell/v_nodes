FROM ubuntu:18.04

RUN apt-get update && apt-get install -y virt-manager rand virtinst

COPY entrypoint.sh /var/tmp/entrypoint.sh

RUN echo 'user = "root"' >> /etc/libvirt/qemu.conf
RUN echo 'group = "root"' >> /etc/libvirt/qemu.conf

RUN chmod +x /var/tmp/entrypoint.sh && ls -ltr /var/tmp/entrypoint.sh

ENTRYPOINT [ "/var/tmp/entrypoint.sh" ]

CMD ["create_nodes"]
