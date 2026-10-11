{ pkgs, ... }:
{
    environment.systemPackages = [ pkgs.cifs-utils ];

    fileSystems."/mnt/nas-storage" = {
        device = "//192.168.0.132/storage-share";
        fsType = "cifs";
        options = [
            "credentials=/etc/nixos/smb-secrets"
            "uid=1000"
            "gid=100"
            "vers=3.0"
            "noauto"
            "x-systemd.automount"
            "x-systemd.idle-timeout=60"
            "x-systemd.mount-timeout=5"
            "_netdev"
        ];
    };
    fileSystems."/mnt/nas-media" = {
        device = "//192.168.0.132/media";
        fsType = "cifs";
        options = [
            "credentials=/etc/nixos/smb-secrets"
            "uid=1000"
            "gid=100"
            "vers=3.0"
            "noauto"
            "x-systemd.automount"
            "x-systemd.idle-timeout=60"
            "x-systemd.mount-timeout=5"
            "_netdev"
        ];
    };
}
