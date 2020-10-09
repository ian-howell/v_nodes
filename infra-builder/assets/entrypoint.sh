#!/bin/bash
set -ex

ansible-playbook -v /opt/ansible/playbooks/build-infra.yaml \
  -e local_src_dir="$(pwd)"
tail -f /dev/null
