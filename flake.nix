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
        src = "./"; # should contain init.lua

        # add extra glib packages or binaries
        extraPackages = [
          astal.packages.${system}.io
          astal.packages.${system}.astal3
          astal.packages.${system}.apps
          astal.packages.${system}.auth
          astal.packages.${system}.battery
          astal.packages.${system}.bluetooth
          astal.packages.${system}.greet
          astal.packages.${system}.hyprland
          astal.packages.${system}.mpris
          astal.packages.${system}.network
          astal.packages.${system}.notifd
          astal.packages.${system}.powerprofiles
          astal.packages.${system}.tray
          astal.packages.${system}.wireplumber
          pkgs.gdk-pixbuf
          pkgs.dart-sass
        ];
      };
    };
}
