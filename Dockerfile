FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get install --no-install-recommends -y \
    build-essential \
    ca-certificates \
    curl \
    git \
    gnupg \
    software-properties-common \
    unzip \
    stow \
    vim \
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

RUN mkdir /nix && chown ubuntu:ubuntu /nix

WORKDIR /home/ubuntu
USER ubuntu
ENV USER=ubuntu
ENV HOME=/home/ubuntu

RUN mkdir -p $HOME/.config && chown -R ubuntu:ubuntu $HOME/.config

COPY .config/home-manager/flake.nix /home/ubuntu/.config/home-manager/flake.nix
COPY .config/home-manager/home.nix /home/ubuntu/.config/home-manager/home.nix
COPY .config/nix /home/ubuntu/.config/nix

USER root
RUN chown -R ubuntu:ubuntu $HOME/.config
USER ubuntu

RUN git clone https://github.com/jonifndef/.dotfiles

RUN curl -L https://nixos.org/nix/install | sh

ENV PATH="/home/ubuntu/.nix-profile/bin:${PATH}"

RUN nix run home-manager/master -- switch --flake .config/home-manager#ubuntu
