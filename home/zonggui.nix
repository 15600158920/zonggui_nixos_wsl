{ config, pkgs, lib, ... }:

{
  ############################################
  # Home Manager 基础信息
  ############################################
  home.username = "zonggui";
  home.homeDirectory = "/home/zonggui";
  home.stateVersion = "25.05";

  ############################################
  # GUI / Wayland 应用（全部用户级）
  ############################################
  home.packages = with pkgs; [
    # Wayland & niri
    niri
    wayland
    wayland-utils
    wl-clipboard

    # 状态栏 / shell
    waybar
    dms
    fuzzel

    # 输入法
    fcitx5
    fcitx5-gtk
    fcitx5-configtool
    fcitx5-chinese-addons

    # 常用 GUI
    alacritty
    foot
    kitty
    firefox
    brave
    vscode

    # 工具
    grim
    slurp
    mako
    jq
    eza
    fastfetch
  ];

  ###########################################
  # fish  aliase
  # #########################################
  programs.fish = {
    enable = true;

    shellAliases = {
      c="clear";
      nf="fastfetch";
      pf="fastfetch";
      ff="fastfetch";
      ls="eza -a --icons=always";
      ll="eza -al --icons=always";
      lt="eza -a --tree --level=1 --icons=always";
      lt2="eza -a --tree --level=2 --icons=always";
      lt3="eza -a --tree --level=3 --icons=always";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-wsl";
    };
  };
  ############################################
  # 环境变量（Wayland / 输入法）
  ############################################
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    SDL_IM_MODULE = "fcitx";
  };

  ############################################
  # Home Manager 自身
  ############################################
  programs.home-manager.enable = true;


  home.file = {
  ".config/niri/config.kdl".source = ../dotfiles/niri/config.kdl;

  ".config/kitty/current-theme.conf".source = ../dotfiles/kitty/current-theme.conf;
  ".config/kitty/kitty.conf".source = ../dotfiles/kitty/kitty.conf;
  ".config/kitty/theme.conf".source = ../dotfiles/kitty/theme.conf;

  ".config/fastfetch/config.jsonc".source = ../dotfiles/fastfetch/config.jsonc;

  ##  脚本
  ".local/bin/start-dms".source = ../dotfiles/local_script/start-dms;
  ".local/bin/start-dms".executable = true;
};
}
