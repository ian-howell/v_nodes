#!/bin/bash
set -ex

: "${action:="create"}"

if [[ "${action}" == "create" ]]; then
    ansible-playbook -v -i /opt/ansible/playbooks/inventory.yaml /opt/ansible/playbooks/create.yaml
else
    echo "\${action} value ${action} does not match an expected value"
    exit 1
fi
