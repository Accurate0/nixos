{ config, pkgs, system, lib, ... }:

let
  packageLists = import ./utils/readPackages.nix { inherit pkgs; inherit lib; package-file-path = ./packages.toml; };
  userPackagesFull = packageLists.general ++ packageLists.emulation ++ packageLists.shells ++ packageLists.development;
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./mounts.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 2;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelParams = [ "amd_iommu=on" "iommu=pt" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "aarch64_be-linux" ];
  boot.extraModprobeConfig =
    ''
      options hid_apple fnmode=2
    '';

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.extraHosts =
    ''
      192.168.50.11  rpi
      192.168.50.12  rpi2
      192.168.50.166 gucci-gang
    '';
  services.resolved.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Perth";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.displayManager.lightdm.background = ./resources/lightdm-background.jpg;
  services.xserver.displayManager.lightdm.greeters.gtk.extraConfig =
    ''
      user-background = false
      active-monitor = 0
    '';

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "amd";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anurag = {
    isNormalUser = true;
    description = "anurag";
    extraGroups = [ "networkmanager" "wheel" "kvm" "input" "libvirt" "dailout" "docker" ];
    shell = pkgs.unstable.fish;
    packages = userPackagesFull;
  };

  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0753", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0753", MODE:="0666", ENV{ID_MM_DEVICE_IGNORE}="1"
  '';

  # needed for easyeffects?
  programs.dconf.enable = true;

  programs.nix-ld.enable = true;
  environment.variables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  fonts.fonts = packageLists.fonts;

  # emulation
  services.sshd.enable = false;
  virtualisation.libvirtd.enable = false;
  environment.etc."libvirt/hooks/qemu" = {
    source = ./resources/qemu/qemu;
    mode = "0744";
  };

  environment.etc."libvirt/hooks/qemu.d/win10/prepare/begin/start.sh" = {
    source = ./resources/qemu/start.sh;
    mode = "0744";
  };

  environment.etc."libvirt/hooks/qemu.d/win10/release/end/stop.sh" = {
    source = ./resources/qemu/stop.sh;
    mode = "0744";
  };

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = packageLists.system-packages;

  # docker
  virtualisation.docker.enable = true;

  # fish
  programs.fish.enable = true;
  environment.shells = with pkgs; [ unstable.fish ];

  # urxvtd
  services.urxvtd.enable = true;

  # vim
  programs.vim.defaultEditor = true;

  # test vm
  users.users.nixosvmtest.isNormalUser = true;
  users.users.nixosvmtest.initialPassword = "test";
  users.users.nixosvmtest.packages = packageLists.general;
  users.users.nixosvmtest.group = "nixosvmtest";
  users.groups.nixosvmtest = { };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";
}
