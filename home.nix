{ pkgs, lib, config, ... }:
{
  imports = [
    ./gnome.nix
    ./gnome-extensions.nix
  ];
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
  xdg.userDirs.download = null;
  xdg.userDirs.publicShare = null;
  xdg.userDirs.videos = null;
  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.readFile ./resources/config.fish;
    shellAliases = {
      build = "sudo nixos-rebuild switch --flake $HOME/nixos";
      upgrade = "nix flake update && sudo nixos-rebuild switch --flake $HOME/nixos";
      rollback = "sudo nixos-rebuild switch --rollback --flake $HOME/nixos";
      dry-run = "sudo nixos-rebuild dry-run --flake $HOME/nixos";
      test-build = "sudo nixos-rebuild dry-run --flake $HOME/nixos";
      build-vm = "sudo nixos-rebuild build-vm --flake $HOME/nixos";
      generate-hardware-config = "sudo nixos-generate-config --dir $HOME/nixos";
      gap = "ga && gp";
      ga = "git add . && git commit -a";
      gp = "git push";
    };
  };
}
