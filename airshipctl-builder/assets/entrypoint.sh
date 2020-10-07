#!/bin/bash
set -ex

airshipctl_dir="$ARTIFACTS_DIR/airshipctl"
mkdir -p "$airshipctl_dir"
cd "$airshipctl_dir"

git init
git fetch "$AIRSHIPCTL_REPO" "$AIRSHIPCTL_REF"
git checkout FETCH_HEAD

./tools/deployment/21_systemwide_executable.sh
mkdir -p bin
cp "$(which airshipctl)" bin

# Keep the container alive
tail -f /dev/null
