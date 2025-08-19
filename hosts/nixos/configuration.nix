# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable flakes support in your system
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Enable graphical session (Wayland + Hyprland)
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = false; #or gdm/ly if you prefer
  services.xserver.desktopManager.plasma5.enable = false; #disable desktops

  services.greetd.enable = true;

  services.greetd.settings = {
  default_session = {
    # For Hyprland; dbus-run-session helps apps needing a session bus
    command = "tuigreet --remember --time --cmd 'dbus-run-session Hyprland'";
    user = "greeter";
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;  #useful for legacy apps
  };

  # Install some basic packages
  environment.systemPackages = with pkgs; [
    hyprland #desktop
    waybar #upper bar
    hyprpaper #wallpaper
    wlogout #log out menu
    greetd.tuigreet #login

    bibata-cursors #cursor theme

    kitty #terminal
    firefox #browser
    networkmanager
    git
    wget
    rofi #app launcher
    neofetch

    # TEXT EDITOR
    vscode
    neovim

    # FILE MANAGER
    ranger #file manager
    ueberzugpp #images visualization
    poppler #PDFs visualization
    ffmpegthumbnailer #videos visualization
    atool #Archives

    # BRIGHTNESS AND VOLUME
    brightnessctl
    pamixer #volume
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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable sound
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.agallas = {
    isNormalUser = true;
    description = "agallas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
