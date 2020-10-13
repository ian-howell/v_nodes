#!/bin/bash
set -ex

# TODO: remove this debug information
docker info
curl --insecure https://username:password@127.0.0.1:8443/redfish/v1/Systems/

export USER=root
# https://github.com/sudo-project/sudo/issues/42
echo "Set disable_coredump false" >> /etc/sudo.conf

cp /opt/aiap-artifacts/airshipctl/bin/airshipctl /usr/local/bin/airshipctl
cp -r /opt/aiap-artifacts/airshipctl/ /opt/airshipctl
cp -r /opt/aiap-artifacts/.airship "$HOME"
cd /opt/airshipctl

ansible-playbook -vvv /opt/ansible/playbooks/create-manifests.yaml

# By default, don't build airshipctl - use the binary from the shared volume instead
# ./tools/deployment/21_systemwide_executable.sh
./tools/deployment/22_test_configs.sh
./tools/deployment/23_pull_documents.sh

tail -f /dev/null

if [[ -z "$ISO_TARBALL" ]]; then
  ./tools/deployment/24_build_ephemeral_iso.sh
  # TODO: this doesn't work - resolve it
  # tar --directory=/srv/iso -czf iso.tar.gz ./*
else
  mkdir -p /srv/iso
  tar -xzf "$ISO_TARBALL" --directory /srv/iso
fi

# ./tools/deployment/25_deploy_ephemeral_node.sh
tail -f /dev/null
