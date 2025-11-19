#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

HOST_CONFIG_DIR="$SCRIPT_DIR/.config"
HOST_HOME_DIR=$HOME
mkdir -p "${HOST_CONFIG_DIR}"

docker run -it --rm \
  --user 1000:1000 \
  nix_pde_test \
  bash
