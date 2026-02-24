{
  description = "Nixers - Cian-H's Personal Repo of Janky Packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    hyprcursor-phinger.url = "github:jappie3/hyprcursor-phinger";
    elephant.url = "github:abenz1267/elephant";
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
  in {
    packages = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
        walkerPkg = (inputs.walker.packages.${system} or {}).default or null;
        localPkgs = import ./default.nix {
          inherit pkgs unstablePkgs;
          walker = walkerPkg;
        };
      in
        localPkgs
        // {
          elephant = (inputs.elephant.packages.${system} or {}).default or null;
          walker = walkerPkg;
          zen-browser = (inputs.zen-browser.packages.${system} or {}).default or null;
          hyprcursor-phinger = (inputs.hyprcursor-phinger.packages.${system} or {}).default or null;
        }
    );

    homeManagerModules = {
      hyprcursor-phinger = inputs.hyprcursor-phinger.homeManagerModules.hyprcursor-phinger;
    };

    overlays.default = final: prev: import ./default.nix {pkgs = prev;};
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
