{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  home.username = "agallas";
  home.homeDirectory = "/home/agallas";

  # User packages (installed for your user only)

  home.packages = with pkgs; [

    git
    google-chrome
    obsidian
    anki-bin
    
    # Command‑line utilities
    ripgrep
    fzf
    eza

    # File manager
    xfce.thunar
    ranger            # file manager
    ueberzugpp        # image previews for ranger
    poppler           # PDF preview for ranger
    ffmpegthumbnailer # video thumbnailer for ranger

    atool             # archive extraction helper

    brightnessctl     # brightness control utility
    pamixer           # audio volume control
    mpv               #reproducing audio on anki cards
    unzip
    kitty             # terminal emulator
    rofi-wayland      # application launcher
    neofetch          # system information CLI
    vscode            # graphical text editor

    wget              # command‑line download tool

    # Hyprland environment extras
    waybar            # bar for Hyprland
    hyprpaper         # wallpaper daemon
    #wlogout           # logout menu for wayland
    hyprlock
    hyprshot
  ];

  # Copia la startpage a ~/.startpage
  home.file.".startpage".source = ./dotfiles/startpage;

  programs.firefox = {
    enable = true;
    profiles."3z7tqry0.default" = {
      isDefault = true;

      settings = {
        "browser.startup.homepage" =
          "file://${config.home.homeDirectory}/.startpage/index.html";
        "browser.startup.page" = 1;
        "browser.newtabpage.activity-stream.enabled" = false;
      };
    };
  };

  # Git
  programs.git = {
    enable = true;
    userName = "Agallas";
    userEmail = "yagovazquez03@gmail.com";
    extraConfig = { init.defaultBranch = "main"; pull.rebase = true; };
  };

  home.sessionVariables = { EDITOR = "nvim"; BROWSER = "firefox"; };

  ############
  # Dotfiles #
  ############

  #carpetas
  xdg.configFile."hypr".source = ./dotfiles/hypr;
  xdg.configFile."kitty".source = ./dotfiles/kitty;
  xdg.configFile."waybar".source = ./dotfiles/waybar;
  xdg.configFile."rofi".source = ./dotfiles/rofi;

  # Ranger (solo archivos sueltos)
  xdg.configFile."ranger/commands.py".source = ./dotfiles/ranger/commands.py;
  xdg.configFile."ranger/commands_full.py".source = ./dotfiles/ranger/commands_full.py;
  xdg.configFile."ranger/rc.conf".source = ./dotfiles/ranger/rc.conf;
  xdg.configFile."ranger/rifle.conf".source = ./dotfiles/ranger/rifle.conf;


  ##################
  # Shell & prompt #
  ##################

  #Permite buscar rápidamente en listas
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  #Sustituto inteligente de cd
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.bat.enable = true; #sustituto de cat con colores, numeración de líneas y resaltado de sintaxis
  programs.eza.enable = true; #sustituto de ls
  programs.ripgrep.enable = true; #buscador ultrarápido de archivos (más que grep)

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      ignoreDups = true;
      save = 50000;
      share = true;
    };

    shellAliases = {
      
      ll = "eza -lah";
      la = "eza -lha";       # incluye archivos ocultos
      lt = "eza -T";         # vista en árbol
      lg = "eza --git";       #info de Git

      cat = "bat";   #mejor vista de archivos

      help = "bat ~/Desktop/comandos_terminal.txt";
      helpvim = "bat ~/Desktop/comandos_neovim.txt";
      update = "sudo nixos-rebuild switch --flake ~/nix-config#nixos";
    };
  };
  programs.starship.enable = true;

  home.stateVersion = "25.05";
}
