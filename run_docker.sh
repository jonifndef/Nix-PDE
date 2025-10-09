#!/bin/bash
set -euo pipefail

HOST_CONFIG_DIR="$(pwd)/.config"
HOST_HOME_DIR=$HOME
mkdir -p "${HOST_CONFIG_DIR}"

docker run -it --rm \
  --user 1000:1000 \
  -v "$HOST_CONFIG_DIR:/home/ubuntu/.config" \
  -v "$HOST_HOME_DIR/.config/nvim:/home/ubuntu/.config/nvim" \
  nix_pde_test \
  bash
