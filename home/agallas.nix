{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "agallas";
  home.homeDirectory = "/home/agallas";

  # User packages (installed for your user only)

  home.packages = with pkgs; [

    git
    neovim
    firefox

    # Command‑line utilities
    ripgrep
    fzf
    eza
    ranger            # file manager
    ueberzugpp        # image previews for ranger
    poppler           # PDF preview for ranger
    ffmpegthumbnailer # video thumbnailer for ranger
    atool             # archive extraction helper
    brightnessctl     # brightness control utility
    pamixer           # audio volume control

    # Graphical applications
    kitty             # terminal emulator
    rofi              # application launcher
    neofetch          # system information CLI
    vscode            # graphical text editor

    # networking tools
    wget              # command‑line download tool

    # Hyprland environment extras
    waybar            # bar for Hyprland
    hyprpaper         # wallpaper daemon
    wlogout           # logout menu for wayland
  ];

  # Shell & prompt (example)
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.zsh.shellAliases = {
    gs = "git status";
    v = "nvim";
  };

  # Git identity (optional; you already set global config)
  programs.git = {
    enable = true;
    userName = "Agallas";
    userEmail = "yagovazquez03@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  # Environment variables (user scope)
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  # Example: later you can manage dotfiles like Hyprland configs:
  # xdg.configFile."hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;

  # HM’s own state version (set once)
  home.stateVersion = "25.05";
}
