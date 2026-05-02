# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    ./desktop
    ./terminal
    ./development
    # ./programs.nix
    # ./ui
  ];

  home = {
    username = "tor";
    homeDirectory = "/home/tor";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    btop
    ddcutil
    dunst
    eza
    fastfetch
    feh
    font-awesome
    ghostty
    gimp
    gnome-calculator
    harlequin
    heroic
    hyprlock
    hyprpicker
    hyprshot
    kmod
    krita
    lazydocker
    lazygit
    librewolf
    lua
    mpd
    nerd-fonts.iosevka
    nvtopPackages.nvidia
    pavucontrol
    pciutils
    pcsx2
    playerctl
    postgresql
    qemu
    rofi-power-menu
    smile
    steam
    steam-run
    thunar
    thunar-volman
    tumbler
    vim
    virt-manager
    vlc
    waybar
    wl-clipboard
    wlogout
    yazi
  ];
  stylix.targets.rofi.enable = true;

  programs.firefox = {
    enable = true;

    profiles = {
      Tor = {
        # bookmarks, extensions, search engines...
      };
    };
  };

  stylix.targets.firefox.profileNames = [ "Tor" ];

  nix.settings.download-buffer-size = 524288000;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
