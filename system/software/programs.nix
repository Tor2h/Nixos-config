{ config, pkgs, inputs, ... }: {
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

  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  programs.dconf.enable = true;
  virtualisation.docker.enable = true;
  hardware.keyboard.qmk.enable = true;

  home-manager.backupFileExtension = "hmBackup";

  environment.systemPackages = with pkgs; [
    bat
    brightnessctl
    cargo
    calibre
    cliphist
    curl
    docker
    dxvk
    fd
    ffmpeg-full
    ffmpegthumbnailer
    fzf
    gamescope
    gcc
    gnutar
    grimblast
    gzip
    heroic
    htop
    hunspell
    hunspellDicts.th_TH
    hunspellDicts.uk_UA
    hyprpicker
    hyprlock
    hyprshot
    kitty
    koreader
    krita
    libnotify
    librewolf
    lua
    nil
    nodejs
    onlyoffice-desktopeditors
    openssl_3
    p7zip
    pcsx2
    pgadmin4
    polkit_gnome
    prefetch-npm-deps # see server.nix
    proton-vpn
    qmk
    ripgrep
    rustup
    rustc-unwrapped
    smile
    tdf
    luajitPackages.tree-sitter-cli
    typst
    unrar
    unzip
    vkd3d
    wget
    zathura
    zig
    zoxide
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];

  programs.nh = {
    enable = false;
    # clean.enable = true;
    # flake = "/home/tor/.config/nix/nix.conf";
  };
}
