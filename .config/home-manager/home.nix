{ config, pkgs, username, homeDirectory, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.packages = with pkgs; [
    neovim
    ripgrep
    tmux
    nodejs_20
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
        #initExtra = "";
        #dotDir = "";

    oh-my-zsh.enable = true;
  };

  home.file = {
    ".zshrc".source = "${homeDirectory}/.config/home-manager/.dotfiles/zsh/.zshrc";
  };

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };
}
