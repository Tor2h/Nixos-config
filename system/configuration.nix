# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ connixfig, pkgs, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware
      ./software
      ./localization
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


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


  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   users = {
  #     "tor" = import ./home.nix;
  #   };
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
