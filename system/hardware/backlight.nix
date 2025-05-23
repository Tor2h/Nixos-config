{ lib, pkgs, config, ... }: {

  # TODO: script this somehow, in a bar or something
  # `for dir in /sys/class/backlight/*; do brightnessctl s 5%- -d "${dir##*/}" & done`
  # for some reason brightnessctl isnt seeing all monitors so that might be necessary

  # environment.systemPackages = with pkgs; [
  #   # Generic screen brightness control
  #   brightnessctl
  # ]
  # ++ lib.optionals [
  #   # External monitor backlight control via ddc
  #   ddcutil
  # ];


  # If the system is not mobile AND has an Nvidia GPU, the ddcci kernel module will
  # most likely not autodetect monitors as supporting DDC. This somewhat ugly hack
  # is needed as a workaround.
  # https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux/-/issues/7#note_151296583
  hardware.i2c.enable = true;
  services.udev.extraRules = ''
    SUBSYSTEM=="i2c-dev", ACTION=="add",\
    ATTR{name}=="NVIDIA i2c adapter*",\
    TAG+="ddcci",\
    TAG+="systemd",\
    ENV{SYSTEMD_WANTS}+="ddcci@$kernel.service"
  '';

  systemd.services."ddcci@" = {
    description = "ddcci handler";
    after = [ "graphical.target" ];
    before = [ "shutdown.target" ];
    conflicts = [ "shutdown.target" ];
    serviceConfig = {
      Type = "oneshot";
      Restart = "no";
      ExecStart = ''
        ${pkgs.bash}/bin/bash -c 'echo Trying to attach ddcci to %i && success=0 && i=0 && id=$(echo %i | cut -d "-" -f 2) && while ((success < 1)) && ((i++ < 5)); do ${pkgs.ddcutil}/bin/ddcutil getvcp 10 -b $id && { success=1 && echo ddcci 0x37 > /sys/bus/i2c/devices/%i/new_device && echo "ddcci attached to %i"; } || sleep 5; done'
      '';
    };
  };

} 
