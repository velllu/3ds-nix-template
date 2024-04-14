{ lib, dockerTools, stdenv, pkgs }:

stdenv.mkDerivation {
  pname = "devkitarm";
  version = "1.0.0";

  src = dockerTools.pullImage {
    imageName = "devkitpro/devkitarm";
    imageDigest = "sha256:340c466b53961c0d90e7536f6db3364d4bfede0f65a26492c25b118d0a00d82e";
    sha256 = "9AlW1ToxsAn4sr1v1MrGmA/1HMt5rozIMhOOxrfmDlA=";
  };

  dontUnpack = true;

  nativeBuildInputs = [
    pkgs.autoPatchelfHook
  ];

  buildInputs = [
    pkgs.stdenv.cc.cc
    pkgs.ncurses6
    pkgs.zsnes
  ];

  buildPhase = ''
    tar -xf $src

    for archive in $(find *.tar)
    do
      tar -xf $archive
    done
    
    rm -rf opt/devkitpro/pacman

    mkdir -p $out
    cp -r opt $out/opt
  '';

  meta = with lib; {
    license = licenses.mit;
    maintainers = [ ];
  };
}
