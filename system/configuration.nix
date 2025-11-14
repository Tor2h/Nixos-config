{ connixfig, config, pkgs, inputs, lib, defaultWallpaper, ... }:
let
  mangoDesktop = pkgs.writeText "mango-desktop" ''
    [Desktop Entry]
    Type=Application
    Name=Mango
    Comment=Mango Wayland Compositor
    Exec=mango
    TryExec=mango
    DesktopNames=Mango
  '';
  mangoDesktopPath = "${pkgs.runtimeShell}/bin/runtimeShell -E 'export XDG_DATA_DIRS=${pkgs.lib.makeLibraryPath [ mangoDesktop ]}:$XDG_DATA_DIRS'";
in
{
  environment.sessionVariables = {
    XDG_DATA_DIRS = mangoDesktopPath;
  };

  nixpkgs.overlays = [
    (self: super: {
      xdg-desktop-portal = super.xdg-desktop-portal.overrideAttrs (oldAttrs: {
        postInstall = ''
          ${oldAttrs.postInstall or ""}
          mkdir -p $out/share/wayland-sessions
          cp ${./mango.desktop} $out/share/wayland-sessions/mango.desktop
        '';
      });

      sddm = super.sddm.overrideAttrs (oldAttrs: {
        postInstall = ''
          ${oldAttrs.postInstall or ""}
          mkdir -p $out/share/wayland-sessions
          cp ${./mango.desktop} $out/share/wayland-sessions/mango.desktop
        '';
      });
    })
  ];

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware
      ./software
      ./localization
    ];

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;

      windows = {
        "windows" =
          let
            # To determine the name of the windows boot drive, boot into edk2 first, then run
            # `map -c` to get drive aliases, and try out running `FS1:`, then `ls EFI` to check
            # which alias corresponds to which EFI partition.
            boot-drive = "FS1";
          in
          {
            title = "Windows";
            efiDeviceHandle = boot-drive;
            sortKey = "y_windows";
          };
      };

      edk2-uefi-shell.enable = true;
      edk2-uefi-shell.sortKey = "z_edk2";
    };
  };

  services.displayManager.sddm = {
    enable = true; # Enable SDDM.
    wayland.enable = true;
    enableHidpi = true;
    sugarCandyNix = {
      enable = true;
      settings = {
        # General settings
        Background = lib.cleanSource defaultWallpaper;
        ScreenWidth = 2560;
        ScreenHeight = 1440;
        Font = "Iosevka nerd font";
        # Form settings
        HeaderText = "Welcome!";
        FormPosition = "left";
        HaveFormBackground = true;
        PartialBlur = true;
        # Customize colors
        BackgroundColor = "#0c0b11";
        MainColor = "#908caa";
        AccentColor = "#9ccfd8";
      };
    };
  };

  # nixpkgs.overlays = [
  #   (self: super: {
  #     sddm = super.sddm.overrideAttrs (oldAttrs: {
  #       postInstall = ''
  #         ${oldAttrs.postInstall or ""}
  #         mkdir -p $out/share/wayland-sessions
  #         cp ${./mango.desktop} $out/share/wayland-sessions/mango.desktop
  #       '';
  #     });
  #   })
  # ];
  #
  # environment.etc."wayland-sessions/mango.desktop".text = ''
  #   [Desktop Entry]
  #   Type=Application
  #   Name=Mango
  #   Comment=Mango Wayland Compositor
  #   Exec=mango
  #   TryExec=mango
  #   DesktopNames=Mango
  # '';


  # Enable the KDE Plasma Desktop Environment.
  # services.desktopManager.plasma6.enable = true;

  # Configure console keymap
  console.keyMap = "dk-latin1";

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.configPackages = [ pkgs.xdg-desktop-portal-gtk ];

  environment.systemPackages = with pkgs; [
    nodejs
    dotnetCorePackages.sdk_9_0_1xx-bin
    nodePackages."@angular/cli"
    vscode-js-debug
    netcoredbg
    inputs.mangowc.packages.${pkgs.system}.mango
    mangoDesktop
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    netcoredbg
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
