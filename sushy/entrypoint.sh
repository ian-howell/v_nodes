#!/bin/bash
set -ex

ANSIBLE_USER=${ansible_user:-ubuntu}
ANSIBLE_SSH_PASS=${ansible_ssh_pass}
: "${action:="start"}"

sushy-emulator --port 8000 --libvirt-uri "qemu:///system" -i 0.0.0.0

if [[ "${action}" == "start" ]]; then
    ansible-playbook -v -i /opt/ansible/playbooks/inventory.yaml /opt/ansible/playbooks/start.yaml
else
    echo "\${action} value ${action} does not match an expected value"
    exit 1
fi
