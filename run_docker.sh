#!/bin/bash
set -euo pipefail

HOST_CONFIG_DIR="$(pwd)/.config"
mkdir -p "${HOST_CONFIG_DIR}"

docker run -it --rm \
  --user 1000:1000 \
  -v "$HOST_CONFIG_DIR:/home/ubuntu/.config" \
  nix_pde_test \
  bash
