{
  description = "Home Manager configuration of ubuntu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay/800a400cde11cbdc9296bc3246869495560d2c9e";
  };

  outputs =
    { nixpkgs, home-manager, self, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    in
    {
      homeConfigurations."ubuntu" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          {
            nixpkgs.overlays = overlays;
          }
        ];

        extraSpecialArgs = {
          homeDirectory = "/home/ubuntu";
        };
      };
    };
}
