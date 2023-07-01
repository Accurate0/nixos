{ config, pkgs, lib, ... }:
with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "gtktitlebar@velitasali.github.io"
        "noannoyance@daase.net"
        "dash-to-panel@jderose9.github.com"
        "alttab-mod@leleat-on-github"
        "clipboard-indicator@tudmotu.com"
        "no-overview@fthx"
      ];
    };

    "org/gnome/system/location" = {
      enabled = false;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      color-scheme = "default";
      enable-hot-corners = false;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      switch-to-workspace-left = [ "<Super>1" ];
      switch-to-workspace-right = [ "<Super>2" ];
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      search-view = "list-view";
      show-delete-permanently = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-last-coordinates = mkTuple [ (-37.77481833988481) 144.833283 ];
      night-light-temperature = mkUint32 2300;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>c";
      command = "firefox";
      name = "firefox";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>Return";
      command = "urxvtc";
      name = "terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>d";
      command = "discord";
      name = "discord";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      binding = "<Super>z";
      command = "spotify";
      name = "spotify";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
      binding = "<Super>t";
      command = "nautilus";
      name = "files";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
      binding = "Print";
      command = "scrot";
      name = "screenshot";
    };
  };

  home.packages = with pkgs; [
    gnomeExtensions.gtk-title-bar
    gnomeExtensions.dash-to-panel
    gnomeExtensions.alttab-mod
    gnomeExtensions.no-overview
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.no-overview
  ];
}
