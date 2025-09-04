{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "agallas";
  home.homeDirectory = "/home/agallas";


  # User packages (installed for your user only)

  home.packages = with pkgs; [

    git
    neovim
    wordgrinder
    google-chrome
    
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

    unzip
    kitty             # terminal emulator
    rofi              # application launcher
    neofetch          # system information CLI

    vscode            # graphical text editor

    wget              # command‑line download tool

    flameshot         #screenshots

    # Hyprland environment extras
    waybar            # bar for Hyprland
    hyprpaper         # wallpaper daemon
    #wlogout           # logout menu for wayland
    hyprlock
  ];


  # Copia la startpage a ~/.startpage
  home.file.".startpage".source = ./dotfiles/startpage;

programs.firefox = {
  enable = true;

  # usa el perfil real que ves en ~/.mozilla/firefox
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

  # Shell & prompt
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.zsh.shellAliases = { gs = "git status"; v = "nvim"; };

  # Git
  programs.git = {
    enable = true;
    userName = "Agallas";
    userEmail = "yagovazquez03@gmail.com";
    extraConfig = { init.defaultBranch = "main"; pull.rebase = true; };
  };

  home.sessionVariables = { EDITOR = "nvim"; BROWSER = "firefox"; };

  # Dotfiles
  xdg.configFile."hypr".source = ./dotfiles/hypr;
  xdg.configFile."kitty".source = ./dotfiles/kitty;
  xdg.configFile."waybar".source = ./dotfiles/waybar;
  xdg.configFile."rofi".source = ./dotfiles/rofi;

  # Ranger (solo archivos sueltos)
  xdg.configFile."ranger/commands.py".source = ./dotfiles/ranger/commands.py;
  xdg.configFile."ranger/commands_full.py".source = ./dotfiles/ranger/commands_full.py;
  xdg.configFile."ranger/rc.conf".source = ./dotfiles/ranger/rc.conf;
  xdg.configFile."ranger/rifle.conf".source = ./dotfiles/ranger/rifle.conf;

  home.stateVersion = "25.05";
}
