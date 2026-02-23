{pkgs}:
pkgs.python314.withPackages (ps:
    with ps; [
      pkginfo
      setuptools
    ])
