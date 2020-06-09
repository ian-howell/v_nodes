FROM ubuntu:20.04

SHELL ["bash", "-exc"]
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update ;\
    apt-get dist-upgrade -y ;\
    apt-get install -y \
        python3-minimal \
        python3-pip \
        python3-apt \
        python3-libvirt \
        curl \
        python3-setuptools; \
    pip3 install --upgrade sushy ;\
    pip3 install --upgrade sushy-tools ;\
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /opt/bin/entrypoint.sh

RUN chmod +x /opt/bin/entrypoint.sh && ls -ltr /opt/bin/entrypoint.sh

CMD /opt/bin/entrypoint.sh
