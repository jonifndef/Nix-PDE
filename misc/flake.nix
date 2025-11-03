{
  description = "My dev tools with Neovim nightly";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay/800a400cde11cbdc9296bc3246869495560d2c9e";
  };

  outputs = { nixpkgs, self, neovim-nightly-overlay, ... }: {
    packages.x86_64-linux.default = let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
        overlays = [ neovim-nightly-overlay.overlays.default ];
    };
    in pkgs.buildEnv {
      name = "my-dev-env";
      paths = with pkgs; [
        ripgrep
        neovim
      ];
    };
  };
}
