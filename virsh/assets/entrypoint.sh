#!/bin/bash
set -ex

: "${action:="create"}"

if [[ "${action}" == "create" ]]; then
#    virsh pool-autostart default
#    virsh pool-start default
    
    ansible-playbook -v -i /opt/ansible/playbooks/inventory.yaml /opt/ansible/playbooks/create-nodes.yaml -vv
else
    echo "\${action} value ${action} does not match an expected value"
    exit 1
fi
