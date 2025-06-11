{ stdenv, fetchgit, python3, rustc, autoconf213, pkg-config, yasm, lib, git, ... }:

stdenv.mkDerivation rec {
  pname = "waterfox";
  version = "6.5.9"; # Replace with desired version

  src = fetchgit {
    url = "https://github.com/WaterfoxCo/Waterfox";
    rev = "4b4341d754042bc90a242a612ee926fb8918d4d4"; # commit for 6.5.9
    sha256 = "sha256-m45xx0ufNyR4UgRRDz48P/R6NVi+jMm2KCScZYyX+rI="; # Replace with correct hash
    fetchSubmodules = false;
  };

  nativeBuildInputs = [ python3 rustc autoconf213 pkg-config yasm git ];
  buildInputs = [ ];

  configurePhase = ''
    export SHELL=/bin/sh
    ./mach configure
  '';

  buildPhase = ''
    # Waterfox uses a Mozilla-style build system
    ./mach build
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r obj-*/dist/bin/* $out/bin/
  '';

  meta = {
    description = "The Waterfox web browser";
    homepage = "https://www.waterfox.net/";
    license = lib.licenses.mpl20;
    platforms = lib.platforms.linux;
  };
}

