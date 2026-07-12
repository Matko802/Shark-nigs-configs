{
  description = "Matko's NixOS System Flake";

  inputs = {
    # Using the unstable channel, matching what you had
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixcord.url = "github:4evy/nixcord";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.matko = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # This passes your inputs to other files
      specialArgs = { inherit inputs; };

      # This tells the flake to use your existing config
      modules = [
        ./configuration.nix
      ];
    };
  };
}
