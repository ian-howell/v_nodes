ARG BASE_IMAGE
FROM ${BASE_IMAGE}

SHELL ["bash", "-exc"]
ENV DEBIAN_FRONTEND noninteractive

ARG ARTIFACTS_DIR=/opt/aiap-artifacts
ENV ARTIFACTS_DIR=$ARTIFACTS_DIR

# Update distro and install common reqs
RUN apt-get update ;\
    apt-get dist-upgrade -y ;\
    apt-get install -y \
        python3-minimal \
        python3-pip \
        python3-setuptools \
        python3-libvirt \
        curl \
        make \
        sudo \
        iproute2 \
        bridge-utils \
        iputils-ping \
        net-tools \
        less \
        vim \
        openssh-client ;\
    pip3 install --upgrade wheel ;\
    pip3 install --upgrade ansible ;\
    rm -rf /var/lib/apt/lists/* ; \
    mkdir -p "$ARTIFACTS_DIR"
