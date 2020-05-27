#!/bin/bash
set -ex

ANSIBLE_USER=${ansible_user:-ubuntu}
ANSIBLE_SSH_PASS=${ansible_ssh_pass}
echo "Going through my entrypoint"
