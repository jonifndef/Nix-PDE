# nix run github:nix-community/home-manager/master -- switch --flake /home/ubuntu/.config/home-manager#ubuntu && zsh

{ config, pkgs, homeDirectory, ... }:

{
  home.stateVersion = "25.05";
  home.username = "ubuntu";
  home.homeDirectory = /home/ubuntu;

  home.packages = with pkgs; [
    neovim
    ripgrep
  ];

  #home.file = {
  #  ".config/nvim".source = .dotfiles/nvim;
  #};

  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
