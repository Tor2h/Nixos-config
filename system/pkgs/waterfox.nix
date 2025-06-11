{ stdenv, fetchFromGitHub, python3, rust, cmake, pkg-config, yasm, ... }:

stdenv.mkDerivation rec {
  pname = "waterfox";
  version = "master"; # Replace with desired version

  src = fetchFromGitHub {
    owner = "WaterfoxCo";
    repo = "Waterfox";
    rev = "master"; # Replace with desired version tag
    sha256 = "0000000000000000000000000000000000000000000000000000"; # Replace with correct hash
  };

  nativeBuildInputs = [ python3 rust cmake pkg-config yasm ];
  buildInputs = [ ];

  buildPhase = ''
    # Waterfox uses a Mozilla-style build system
    ./mach build
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r obj-x86_64-pc-linux-gnu/dist/bin/* $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "The Waterfox web browser";
    homepage = "https://www.waterfox.net/";
    license = licenses.mpl20;
    platforms = platforms.linux;
  };
}
