#{
#  description = "Personalized Development Environment";
#
#  inputs = {
#    # Specify the source of Home Manager and Nixpkgs.
#    # nixpkgs.url = "github:nixos/nixpkgs/unstable";
#    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
#    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
#    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
#    home-manager = {
#      url = "github:nix-community/home-manager";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };
#  };
#
#  outputs =
#    { nixpkgs, home-manager, neovim-nightly-overlay, ... }:
#    let
#      system = "x86_64-linux";
#      overlays = [ neovim-nightly-overlay.overlay ];
#      #pkgs = nixpkgs.legacyPackages.${system};
#      pks = import nixpkgs {
#        inherit system overlays;
#      };
#    in
#    {
#      homeConfigurations."ubuntu" = home-manager.lib.homeManagerConfiguration {
#        inherit pkgs;
#
#        modules = [ ./home.nix ];
#
#        extraSpecialArgs = {
#	  username = "ubuntu";
#	  homeDirectory = "/home/ubuntu";
#	};
#      };
#    };
#}
#{
#  description = "Personalized Development Environment with Neovim nightly";
#
#  inputs = {
#    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
#
#    neovim-nightly-overlay = {
#      url = "github:nix-community/neovim-nightly-overlay";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };
#
#    home-manager = {
#      url = "github:nix-community/home-manager";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };
#  };
#
#  outputs = inputs @ { nixpkgs, home-manager, neovim-nightly-overlay, ... }: let
#    system = "x86_64-linux";
#    pkgs = import nixpkgs {
#      inherit system;
#      overlays = [ neovim-nightly-overlay.overlay ];
#    };
#  in {
#    homeConfigurations = {
#      ubuntu = home-manager.lib.homeManagerConfiguration {
#        inherit pkgs;
#        modules = [ ./home.nix ];
#
#        extraSpecialArgs = {
#          username = "ubuntu";
#          homeDirectory = "/home/ubuntu";
#        };
#      };
#    };
#  };
#}

{
  inputs = {
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, ... }@inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    in
    {
      homeConfigurations = {
        ubuntu = inputs.home-manager.lib.homeManagerConfiguration {
          modules = [
            {
              nixpkgs.overlays = overlays;
            }
          ];
        };
      };
    };
}
