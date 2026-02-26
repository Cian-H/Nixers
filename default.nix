{
  pkgs ? import <nixpkgs> {},
  unstablePkgs ? pkgs,
  walker ? pkgs.walker or null,
}: {
  python-env = import ./pkgs/python-env/default.nix {inherit pkgs;};
  rbw-autofill = pkgs.callPackage ./pkgs/rbw-autofill/default.nix {};
  tokyonight-kvantum = pkgs.callPackage ./pkgs/tokyonight-kvantum/default.nix {};
  vivaldi-wayland = pkgs.callPackage ./pkgs/vivaldi-wayland/default.nix {};
  walker-obsidian-search = pkgs.callPackage ./pkgs/walker-obsidian-search/default.nix {
    inherit walker;
  };
}
