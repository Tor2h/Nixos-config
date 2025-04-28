{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # various config files
    ./kitty.nix
    # ./fish.nix
    # ./starship.nix
  ];
  config = {
    programs.fastfetch = {
      settings = "

        modules = [
          title,
          separator,
          os,
          host,
          kernel,
          packages,
          shell,
          de,
          wm,
          wmtheme,
          theme,
          icons,
          font,
          terminal,
          cpu,
          gpu,
          break,
          colors,
        ],
              ";
    };
  };
}
