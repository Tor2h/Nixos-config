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
    discord
    dunst
    eza
    fastfetch
    feh
    font-awesome
    freerdp
    ghostty
    gimp
    gnome-calculator
    gnome-text-editor
    gnome-system-monitor
    harlequin
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    # jetbrains.rider
    kmod
    lazydocker
    lazygit
    mpd
    nerd-fonts.iosevka
    nvtopPackages.nvidia
    pavucontrol
    pciutils
    playerctl
    postgresql
    qemu
    rofi-power-menu
    steam
    steam-run
    vim
    virt-manager
    vlc
    waybar
    wl-clipboard
    wlogout
    thunar
    thunar-volman
    tumbler
    yazi
  ];
  stylix.targets.rofi.enable = true;

  nix.settings.download-buffer-size = 524288000;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
