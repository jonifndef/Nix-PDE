#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

HOST_CONFIG_DIR="$SCRIPT_DIR/.config"
HOST_HOME_DIR=$HOME
mkdir -p "${HOST_CONFIG_DIR}"

docker run -it --rm \
  --user 1000:1000 \
  -v "$SCRIPT_DIR/misc:/home/ubuntu/misc" \
  -v "$HOST_CONFIG_DIR/nix:/home/ubuntu/.config/nix" \
  -v "$HOME/.zshrc:/home/ubuntu/.zshrc" \
  nix_pde_test \
  bash -c '
    set -e
    #nix run home-manager/master -- switch --flake .config/home-manager#ubuntu --impure

    #exec zsh
    exec bash
  '
