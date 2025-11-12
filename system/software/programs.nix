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

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "tor" ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

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

  programs.git = {
    enable = true;
    config = {
      user.name = "tor2h";
      user.email = "tor.holm@live.dk";
      init.defaultBranch = "main";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
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
    fzf
    gcc
    gnutar
    grimblast
    gzip
    heroic
    hyprpaper
    kitty
    libnotify
    librewolf
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.th_TH
    lua
    lutris
    nil
    nodejs
    ollama
    pcsx2
    polkit_gnome
    p7zip
    qmk
    ripgrep
    tdf
    unzip
    wget
    zathura
    zig
    zoxide
    wmenu
    wl-clipboard
    grim
    slurp
    swaybg
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "/home/tor/.config/nixos-config";
  };
}
