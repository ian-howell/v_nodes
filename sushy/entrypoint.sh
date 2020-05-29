#!/bin/bash
set -ex

ANSIBLE_USER=${ansible_user:-ubuntu}
ANSIBLE_SSH_PASS=${ansible_ssh_pass}

sushy-emulator --port 8000 --libvirt-uri "qemu:///system" -i 0.0.0.0
