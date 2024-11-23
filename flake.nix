{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, astal, ags }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = ags.lib.bundle {
        inherit pkgs;
        name = "astal";
        src = ./astal;
        entry = "app.ts";

        # nativeBuildInputs = [
        #   ags.packages.${system}.default
        #   pkgs.wrapGAppsHook
        #   pkgs.gobject-introspection
        # ];

        extraPackages = with ags.packages.${system};
          [
            astal3
            io
            battery
            hyprland
            mpris
            network
            tray
            wireplumber
            # any other package
          ] ++ [ pkgs.wrapGAppsHook pkgs.gobject-introspection ];

        # installPhase = ''
        #   mkdir -p $out/bin
        #   ags bundle app.ts $out/bin/${name}
        #   # chmod +x $out/bin/${name}
        # '';
      };
    };
}
