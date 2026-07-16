{
  description = "Matko's NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    gsr-ui-nix = {
      url = "github:rPlakama/gsr-ui-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  helium = {
    url = "github:schembriaiden/helium-browser-nix-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};

  outputs = { nix-cachyos-kernel, self, nixpkgs, helium, ... }@inputs: {
    nixosConfigurations.matko = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix

        (
          { pkgs, ... }:

          {
            nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];

            boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

            nix.settings = {
              extra-substituters = [ "https://attic.xuyh0120.win/lantian" ];
              extra-trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
            };
          }
        )
      ];
    };
  };
}
