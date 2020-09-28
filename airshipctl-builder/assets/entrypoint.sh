#!/bin/bash
set -ex

airshipctl_dir="/opt/airshipctl"
mkdir -p "$airshipctl_dir"
cd "$airshipctl_dir"

git init
git fetch "$AIRSHIPCTL_REPO" "$AIRSHIPCTL_REF"
git checkout FETCH_HEAD

./tools/deployment/21_systemwide_executable.sh

cp /usr/local/bin/airshipctl "$ARTIFACTS_DIR/airshipctl"

tail -f /dev/null
