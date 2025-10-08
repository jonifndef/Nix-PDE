#!/bin/bash
set -euo pipefail

HOST_BASE_DIR="$(pwd)/home"

docker run -it --rm \
  --user 1000:1000 \
  -v "$HOST_BASE_DIR:/home/ubuntu" \
  nix_pde_test \
  bash
