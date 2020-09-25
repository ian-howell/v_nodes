FROM ianhowell/base:test

SHELL ["bash", "-exc"]
ENV DEBIAN_FRONTEND noninteractive

ARG AIRSHIPCTL_REPO=https://github.com/airshipit/airshipctl.git
ARG AIRSHIPCTL_REF=master

ENV AIRSHIPCTL_REPO=$AIRSHIPCTL_REPO
ENV AIRSHIPCTL_REF=$AIRSHIPCTL_REF

# Update distro and install ansible
RUN apt-get update ;\
    apt-get dist-upgrade -y ;\
    apt-get install -y \
        git \
        git-review \
        apt-transport-https \
        ca-certificates \
        gnupg-agent \
        software-properties-common \
        gettext-base ;\
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - ;\
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" ;\
    apt-get install -y --no-install-recommends \
        docker-ce-cli ;\
    rm -rf /var/lib/apt/lists/*

COPY assets /opt/assets/
RUN cp -ravf /opt/assets/* / ;\
    rm -rf /opt/assets

ENTRYPOINT /entrypoint.sh
