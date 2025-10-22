#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#docker build --no-cache -t nix_pde_test .
docker build -t nix_pde_test .
