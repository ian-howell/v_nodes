#!/bin/bash
set -ex

: "${action:="create"}"

if [[ "${action}" == "create" ]]; then
    ansible-playbook -i /opt/assets/playbooks/inventory.yaml /opt/assets/playbooks/create.yaml
else
    echo "\${action} value ${action} does not match an expected value"
    exit 1
fi