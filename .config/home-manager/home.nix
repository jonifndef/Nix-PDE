# nix run github:nix-community/home-manager/master -- switch --flake /home/dev/.config/home-manager#dev && zsh

{ config, pkgs, username, homeDirectory, ... }:

{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    neovim
    ripgrep
  ];

  home.file = {
    ".config/nvim".source = /home/ubuntu/.dotfiles/nvim;
  };

  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
