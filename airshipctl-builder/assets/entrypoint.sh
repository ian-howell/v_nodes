#!/bin/bash
set -ex

airshipctl_dir="/opt/airshipctl"
mkdir -p "$airshipctl_dir"

git clone "$AIRSHIPCTL_REPO" "$airshipctl_dir"

cd "$airshipctl_dir"
git checkout "$AIRSHIPCTL_REF"

./tools/deployment/21_systemwide_executable.sh

cp /usr/local/bin/airshipctl "$ARTIFACTS_DIR/airshipctl"

tail -f /dev/null
