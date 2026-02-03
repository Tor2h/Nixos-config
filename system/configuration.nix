{ config, pkgs, inputs, lib, defaultWallpaper, ... }:
{
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

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    enableTCPIP = true;
    ensureUsers = [
      {
        name = "tor";
      }
    ];
    # port = 5432;
    authentication = pkgs.lib.mkOverride 10 ''
      #...
      #type database DBuser origin-address auth-method
      local all       all     trust
      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host all       all     ::1/128        trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
      CREATE DATABASE nixcloud;
      GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
    '';
  };

  services.displayManager.defaultSession = "hyprland";

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "tor";

  # # enable the nvidia video driver
  # services.xserver.videoDrivers = [ "nvidia" ];
  #
  # # enable nvidia DRM modesetting (required for stable Wayland sessions)
  # hardware.nvidia.modesetting.enable = true;
  #
  # # ensure the nvidia modules are included in the initrd so modesetting is available at boot
  # boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_drm" "nvidia_uvm" ];
  #
  # # make sure the kernel param is passed early (extra safety)
  # boot.kernelParams = [ "nvidia-drm.modeset=1" ];

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
