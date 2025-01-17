 {
  description = "Your NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, zen-browser, ... }: 
    let
      system = "x86_64-linux";  # Correct based on your uname -m output
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {  # Using "nixos" as hostname
        inherit system;
        modules = [
          ./configuration.nix
          ({ pkgs, ... }: {
            environment.systemPackages = [
              zen-browser.packages.${system}.default
            ];
          })
        ];
      };
    };
} 
