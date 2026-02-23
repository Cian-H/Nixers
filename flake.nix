{
  description = "Nixers - Cian-H's Personal Repo of Janky Packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
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
      in
        import ./default.nix {inherit pkgs;}
    );
    overlays.default = final: prev: import ./default.nix {pkgs = prev;};
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
