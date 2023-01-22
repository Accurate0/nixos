{ ... }: {
  fileSystems."/media/c" =
    {
      device = "/dev/disk/by-uuid/D49099EC9099D578";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "gid=1000" "dmask=027" "fmask=137" "user" "users" "noauto" "x-systemd.automount" "nofail" ];
    };
}
