{ lib, ... }:
{
  dconf.settings = {

    "org/gnome/shell/extensions/altTab-mod" = {
      current-monitor-only = true;
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      animate-app-switch = true;
      animate-appicon-hover = true;
      animate-appicon-hover-animation-convexity = "{'RIPPLE': 2.0, 'PLANK': 1.0, 'SIMPLE': 0.0}";
      animate-appicon-hover-animation-duration = "{'SIMPLE': uint32 59, 'RIPPLE': 130, 'PLANK': 100}";
      animate-appicon-hover-animation-extent = "{'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}";
      animate-appicon-hover-animation-rotation = "{'SIMPLE': 0, 'RIPPLE': 10, 'PLANK': 0}";
      animate-appicon-hover-animation-travel = "{'SIMPLE': 0.040000000000000001, 'RIPPLE': 0.40000000000000002, 'PLANK': 0.0}";
      animate-appicon-hover-animation-type = "SIMPLE";
      animate-appicon-hover-animation-zoom = "{'SIMPLE': 1.0, 'RIPPLE': 1.25, 'PLANK': 1.04}";
      appicon-margin = 4;
      appicon-padding = 8;
      available-monitors = [ 0 1 ];
      dot-color-2 = "#c01c28";
      dot-color-dominant = true;
      dot-color-override = false;
      dot-position = "BOTTOM";
      dot-size = 4;
      dot-style-focused = "SOLID";
      dot-style-unfocused = "SOLID";
      focus-highlight-dominant = false;
      focus-highlight-opacity = 20;
      group-apps = false;
      group-apps-label-max-width = 100;
      group-apps-underline-unfocused = true;
      group-apps-use-fixed-width = false;
      group-apps-use-launchers = false;
      hotkeys-overlay-combo = "TEMPORARILY";
      intellihide = false;
      intellihide-hide-from-windows = false;
      isolate-monitors = true;
      isolate-workspaces = true;
      leftbox-padding = -1;
      leftbox-size = 0;
      middle-click-action = "LAUNCH";
      multi-monitors = false;
      overview-click-to-exit = false;
      panel-anchors = ''
        {"0":"END","1":"MIDDLE"}
      '';
      panel-element-positions = ''
        {"0":[{"element":"showAppsButton","visible":true,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":false,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":false,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}],"1":[{"element":"showAppsButton","visible":true,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}
      '';
      panel-element-positions-monitors-sync = true;
      panel-lengths = ''
        {"0":100,"1":100}
      '';
      panel-positions = ''
        {"0":"BOTTOM","1":"BOTTOM"}
      '';
      panel-sizes = ''
        {"0":44,"1":44}
      '';
      primary-monitor = 0;
      secondarymenu-contains-showdetails = false;
      shift-click-action = "LAUNCH";
      shift-middle-click-action = "LAUNCH";
      show-appmenu = false;
      show-apps-icon-file = "";
      show-apps-icon-side-padding = 4;
      show-apps-override-escape = true;
      show-favorites = true;
      show-favorites-all-monitors = true;
      show-running-apps = true;
      show-showdesktop-hover = true;
      status-icon-padding = 6;
      stockgs-force-hotcorner = false;
      stockgs-keep-dash = false;
      stockgs-keep-top-panel = false;
      stockgs-panelbtn-click-only = false;
      trans-bg-color = "#000000";
      trans-panel-opacity = 0.8;
      trans-use-custom-bg = true;
      trans-use-custom-opacity = true;
      trans-use-dynamic-opacity = false;
      tray-padding = 0;
      tray-size = 0;
      window-preview-size = 160;
      window-preview-title-position = "TOP";
    };

    "org/gnome/shell/extensions/gtktitlebar" = {
      hide-window-titlebars = "always";
      restrict-to-primary-screen = false;
    };
  };
}
