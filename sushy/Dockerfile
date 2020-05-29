FROM ubuntu:18.04

ENV SSH_USER "StaceyFletcher"
ENV AIRSHIP_CTL_REPO "review.opendev.org:29418/airship/airshipctl"

RUN apt-get update && apt-get install -y git python3-pip python3-libvirt

RUN pip3 install sushy
RUN pip3 install sushy-tools
COPY entrypoint.sh /opt/bin/entrypoint.sh

CMD /opt/bin/entrypoint.sh
