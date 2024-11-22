{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, astal }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = astal.lib.mkLuaPackage {
        inherit pkgs;
        name = "my-shell"; # how to name the executable
        src = ./lua; # should contain init.lua

        # add extra glib packages or binaries
        extraPackages = [ astal.packages.${system}.battery pkgs.dart-sass ];
      };
    };
}
