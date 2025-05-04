{ config, pkgs, ... }: {
  imports = [ ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.firefox.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable zsh as default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  services = {
    dbus.enable = true;
    gvfs.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    udisks2.enable = true;
    openssh.enable = true;
    libinput.enable = true;
    trezord.enable = true;
  };


  programs.dconf.enable = true;
  programs.light.enable = true;
  virtualisation.docker.enable = true;
  hardware.keyboard.qmk.enable = true;

  home-manager.backupFileExtension = "hmBackup";

  environment.systemPackages = with pkgs; [
    nodejs
    prefetch-npm-deps # see server.nix
    brightnessctl
    cargo
    cliphist
    curl
    docker
    ffmpeg-full
    ffmpegthumbnailer
    gcc
    git
    gnutar
    grimblast
    gzip
    kitty
    libnotify
    lua
    neovim
    nil
    nodejs
    ripgrep
    unzip
    wget
    zig
    zoxide
    polkit_gnome
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "/home/tor/.config/nixos-config";
  };
}
