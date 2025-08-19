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
    ripgrep
    fzf
    eza
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
EOF

