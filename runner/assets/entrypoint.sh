#!/bin/bash
set -ex
docker info
curl --insecure https://username:password@127.0.0.1:8443/redfish/v1/Systems/

git clone https://github.com/airshipit/airshipctl.git /opt/airshipctl

cd /opt/airshipctl
make docker-image
docker run --rm quay.io/airshipit/airshipctl:dev version
docker run --rm quay.io/airshipit/airshipctl:dev --help

./tools/deployment/21_systemwide_executable.sh
./tools/deployment/22_test_configs.sh
./tools/deployment/23_pull_documents.sh
export USER=root
#https://github.com/sudo-project/sudo/issues/42
echo "Set disable_coredump false" >> /etc/sudo.conf
./tools/deployment/24_build_ephemeral_iso.sh
#./tools/deployment/25_deploy_ephemeral_node.sh
tail -f /dev/null