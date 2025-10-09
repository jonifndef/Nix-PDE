# nix run github:nix-community/home-manager/master -- switch --flake /home/dev/.config/home-manager#dev && zsh

{ config, pkgs, ... }:

let 
  username = builtins.getEnv "USER";
  homedir  = builtins.getEnv "HOME";
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = homedir;

  home.stateVersion = "25.05";

  home.packages = [
    neovim-nightly
    ripgrep
  ];

  home.file = {
    ".config/nvim".source = ~/.dotfiles/nvim;
  };

  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
