# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # ./nvim
    # ./firefox
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
    ddcutil
    btop
    discord
    fastfetch
    font-awesome
    gimp
    gnome-calculator
    gnome-text-editor
    gnome-system-monitor
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    lazydocker
    lazygit
    mpd
    neofetch
    nerd-fonts.iosevka
    pavucontrol
    playerctl
    rofi-wayland
    rofi-power-menu
    spotify
    steam
    steam-run
    vim
    vlc
    waybar
    wl-clipboard
    wofi
    xfce.thunar
    xfce.thunar-volman
    xfce.tumbler
    kdePackages.xwaylandvideobridge
    yazi
  ];
  stylix.targets.rofi.enable = true;


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
