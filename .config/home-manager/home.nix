{ config, pkgs, username, homeDirectory, ... }:

{
  home.stateVersion = "25.05";
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.packages = with pkgs; [
    neovim
    ripgrep
    zsh
        #oh-my-zsh
    tmux
    nodejs_20
  ];

  programs.zsh = {
    enable = true;
    dotDir = "";
    initExtra = "";

        oh-my-zsh = {
          enable = true;
          theme = "";    # don’t set, you manage this manually
          plugins = [ ];   # don’t let HM inject plugins
        };
  };

# Install oh-my-zsh & plugins, but don’t touch .zshrc
    #programs.zsh.oh-my-zsh = {
    #  enable = true;
    #  theme = "";           # Don’t set a theme
    #  plugins = [ ];          # Don’t let HM source them automatically
    #};

  # Manually install plugins so they exist in your profile
    #home.packages = with pkgs; [
    #  zsh-autosuggestions
    #  zsh-syntax-highlighting
    #];

  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
