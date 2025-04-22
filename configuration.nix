# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{

  # Grub, use latest kernel
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam, Virt cam" exclusive_caps=1
  '';
  security.polkit.enable = true;
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    device = "nodev";
    efiSupport = true;
  };


  # Define hostname
  networking.hostName = "protogen-13"; 
  
  # Enable networking.
  networking.networkmanager.enable = true;

  # Enable Nix-command & Flakes
  nix.settings.experimental-features = [
  "nix-command"  "flakes" ];  

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Define system services, enable syncthing, mullvad. 
  services = {
      syncthing = {
          enable = true;
          user = "yuka";
          dataDir = "/home/yuka/Documents";    # Default folder for new synced folders
          configDir = "/home/yuka/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
      };
      mullvad-vpn.enable = true;
      rpcbind.enable = true; 
  };

  # Enable Plasma6 & SDDM.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
   
  # Configure keymap in X11.
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define user account.
  users.users.yuka = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "yukaira";
    extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" ];
    packages = with pkgs; [
    ];
  };

  # Enable ZSH.
  programs.zsh.enable = true;

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Define system packages.
  environment.systemPackages = with pkgs; [
  appimage-run
  bat
  micro
  tree
  wget
  piper
  mullvad-vpn
  rar
  nfs-utils
  pika-backup
  linux-wallpaperengine
  ];

  # Enable Git.
  programs.git.enable = true;

  # Enable Steam.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Enable Opentabletdriver
  hardware.opentabletdriver.enable = true;

  # Enable Bluetooth 
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable ADB 
  programs.adb.enable = true; 

  # Open ports
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  
  networking.firewall.allowedTCPPorts = [ 111 2049 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 111 2049 22000 21027 ];

  # Enable KDE connect 
  programs.kdeconnect.enable = true; 

  # Enable AMDGPU  
  boot.initrd.kernelModules = [ "amdgpu" "nfs" ];
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # AMDGPU openCL support 
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  # Enable ratbagd for piper
  services.ratbagd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
