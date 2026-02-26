{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "tokyo-night-kvantum";
  version = "unstable-main";

  src = fetchFromGitHub {
    owner = "0xsch1zo";
    repo = "Kvantum-Tokyo-Night";
    rev = "main";
    hash = "sha256-Uy/WthoQrDnEtrECe35oHCmszhWg38fmDP8fdoXQgTk=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/Kvantum
    cp -r Kvantum-Tokyo-Night $out/share/Kvantum/

    runHook postInstall
  '';

  meta = with lib; {
    description = "A Kvantum theme for the Tokyo Night color palette";
    homepage = "https://github.com/0xsch1zo/Kvantum-Tokyo-Night";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
