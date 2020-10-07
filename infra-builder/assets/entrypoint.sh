#!/bin/bash
set -ex

ansible-playbook -vvv /opt/ansible/playbooks/build-infra.yaml \
  -e local_src_dir="$(pwd)"
