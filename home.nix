{ pkgs, lib, config, ... }:
{
  home.stateVersion = "22.11";
  programs.git = {
    enable = true;
    userName = "Anurag Singh";
    userEmail = "contact@anurag.sh";
    includes = [{ path = ./resources/gitconfig; }];
  };
  xresources.extraConfig = builtins.readFile ./resources/Xresources;
  xsession.enable = true;
  xsession.profileExtra =
    ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge "/home/anurag/.Xresources"
    '';
  # manage normal direcories with xdg
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.userDirs.documents = null;
  xdg.userDirs.templates = null;
  xdg.userDirs.music = null;
  xdg.userDirs.pictures = null;
  xdg.userDirs.publicShare = null;
  xdg.userDirs.videos = null;
  home.file = with config.lib.file; {
    Projects.source = mkOutOfStoreSymlink "/media/arch/home/anurag/Projects";
    Pictures.source = mkOutOfStoreSymlink "/media/arch/home/anurag/Pictures";
    Wallpapers.source = mkOutOfStoreSymlink "/media/arch/home/anurag/Wallpapers";
    ".bin".source = mkOutOfStoreSymlink "/media/arch/home/anurag/.bin";
    Testing.source = mkOutOfStoreSymlink "/media/arch/home/anurag/Testing";
    ".ssh".source = mkOutOfStoreSymlink "/media/arch/home/anurag/.ssh";
    Screenshots.source = mkOutOfStoreSymlink "/media/arch/home/anurag/Screenshots";
  };
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = builtins.readFile ./resources/config.fish;
}
