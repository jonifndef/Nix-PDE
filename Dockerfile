FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get install --no-install-recommends -y \
    build-essential \
    ca-certificates \
    curl \
    gnupg \
    software-properties-common \
    unzip \
    wget \
    xz-utils

RUN add-apt-repository ppa:git-core/ppa -y && \
    apt-get update && \
    apt-get install -y git

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install --no-install-recommends -y nodejs && \
    npm install -g npm@latest

RUN (getent group 1000 || groupadd -g 1000 ubuntu) && \
    (getent passwd 1000 || useradd -m -u 1000 -g 1000 -s /bin/bash ubuntu || true) && \
    mkdir -p /home/ubuntu && \
    chown -R 1000:1000 /home/ubuntu || true

RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz && tar -xzf nvim-linux-x86_64.tar.gz -C /opt/

RUN mkdir /nix && chown ubuntu:ubuntu /nix

WORKDIR /home/ubuntu
USER ubuntu
ENV USER=ubuntu

RUN curl -L https://nixos.org/nix/install | sh

RUN mkdir -p $HOME/.config && chown ubuntu:ubuntu $HOME/.config

ENV PATH="/home/ubuntu/.nix-profile/bin:/opt/nvim-linux-x86_64/bin:${PATH}"
