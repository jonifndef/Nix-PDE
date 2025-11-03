{
  description = "My dev tools with Neovim nightly";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, self, ... }: {
    packages.x86_64-linux.default = let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
    };
    in pkgs.buildEnv {
      name = "my-dev-env";
      paths = with pkgs; [
        ripgrep
      ];
    };
  };
}
