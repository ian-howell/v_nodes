#!/bin/bash
set -ex

# TODO: remove this debug information
docker info
curl --insecure https://username:password@127.0.0.1:8443/redfish/v1/Systems/

export USER=root
# https://github.com/sudo-project/sudo/issues/42
echo "Set disable_coredump false" >> /etc/sudo.conf

cp /opt/aiap-artifacts/airshipctl /usr/local/bin/airshipctl

git clone https://github.com/airshipit/airshipctl.git /opt/airshipctl
git clone https://github.com/ian-howell/v_nodes.git /tmp/v_nodes
ansible-playbook -v -i /tmp/v_nodes/opt/ansible/playbooks/inventory.yaml /tmp/v_nodes/virsh/assets/opt/ansible/playbooks/create-manifests.yaml -vv

cd /opt/airshipctl
# By default, don't build airshipctl - use the binary from the shared volume instead
# ./tools/deployment/21_systemwide_executable.sh

echo "Install airshipctl as kustomize plugins"
AIRSHIPCTL="/usr/local/bin/airshipctl" ./tools/document/build_kustomize_plugin.sh
./tools/deployment/22_test_configs.sh
./tools/deployment/23_pull_documents.sh

if [[ -z "$ISO_TARBALL" ]]; then
  ./tools/deployment/24_build_ephemeral_iso.sh
  tar --directory=/srv/iso -czf iso.tar.gz *
else
  mkdir -p /srv/iso
  cd /srv/iso
  tar -xzf "$ISO_TARBALL"
fi

# ./tools/deployment/25_deploy_ephemeral_node.sh
tail -f /dev/null
