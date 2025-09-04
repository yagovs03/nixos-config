{ config, pkgs, lib, ... }:

let
  cfg = config.myEditors.lazyvim;
in {
  options.myEditors.lazyvim.enable = lib.mkEnableOption "LazyVim setup (Neovim + deps)";

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;

      # Herramientas que LazyVim / LSPs suelen necesitar
      extraPackages = with pkgs; [
        ripgrep
        fd
        unzip
        gcc
        gnumake
        pkg-config
        tree-sitter

        # LSPs / linters / formatters útiles
        lua-language-server
        stylua
        nodejs
        typescript-language-server
        bash-language-server
        yaml-language-server
        pyright
        black
        prettierd
        nil # Nix LSP
      ];
    };

    # (Paso 4) Enlazamos tu config de LazyVim desde el repo
    xdg.configFile."nvim".source = ../../dotfiles/nvim;
  };
}

