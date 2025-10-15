{ config, pkgs, username, homeDirectory, ... }:

{
  home.stateVersion = "25.05";
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.packages = with pkgs; [
    neovim
    ripgrep
  ];

  home.file = {
    ".config/nvim".source = ./.dotfiles/nvim/.config/nvim;
  };

  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
