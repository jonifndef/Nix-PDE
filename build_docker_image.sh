#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cp -r $HOME/.dotfiles $SCRIPT_DIR/.config/home-manager/
docker build --no-cache -t nix_pde_test .
