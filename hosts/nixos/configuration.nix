# Edit this configuration file to define what should be installed on your system.

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];


  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = { automatic = true; dates = "weekly"; options = "--delete-older-than 14d"; };
  boot.tmp.cleanOnBoot = true;

  # Wayland + Hyprland (No X server)

  services.greetd.enable = true;
  services.greetd.settings = {
  default_session = {
    # For Hyprland; dbus-run-session helps apps needing a session bus
    command = "tuigreet --remember --time --cmd 'dbus-run-session Hyprland'";
    user = "agallas";
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;  #useful for legacy apps
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
  };

  security.rtkit.enable = true;
  hardware.graphics.enable = true;

  # Install system‑level packages
  environment.systemPackages = with pkgs; [
    
    greetd.tuigreet # greetd runs as root and launches the greeter binary
    bibata-cursors # Provide the Bibata cursor theme system‑wide (affects the login screen).
    tree #Provide tree visualization of files

  ];

  #Fonts
  fonts = {
    enableDefaultPackages = true;         # usually already true
    fontDir.enable = true;                # exposes fonts under /run/current-system/sw/share/X11/fonts
    packages = with pkgs; [
      ultimate-oldschool-pc-font-pack                  # includes "PxPlus IBM VGA 9x16"
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # Enable networking
  networking.networkmanager.enable = true;

  # Enable sound
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  # Power / firmware
  services.tlp.enable = true;
  services.fwupd.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "es";
  
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.agallas = {
    isNormalUser = true;
    description = "agallas";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "25.05";

}
