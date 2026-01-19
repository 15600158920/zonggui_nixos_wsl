{ config, lib, pkgs, ... }:

{
  ### ===========================
  ### home-manager
  ### ===========================
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    backupFileExtension = "bak";

    users.zonggui = import ./home/zonggui.nix;
  };
  ### =========================
  ### WSL
  ### =========================
  wsl.enable = true;
  wsl.defaultUser = "zonggui";

  networking.hostName = "nixos-wsl";
  time.timeZone = "Asia/Shanghai";

  ### =========================
  ### Nix
  ### =========================
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [
      "https://cache.nixos.org/"
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=10"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=5"
    ];

    download-buffer-size = 524288000;
  };

  nixpkgs.config.allowUnfree = true;
  programs.command-not-found.enable = false;

  ### =========================
  ### 用户
  ### =========================
  users.users.zonggui = {
    isNormalUser = true;
    description = "zonggui";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  security.sudo.wheelNeedsPassword = false;
  programs.fish.enable = true;

  ### =========================
  ### system 级工具（非 GUI）
  ### =========================
  environment.systemPackages = with pkgs; [
    git
    stow
    helix
    jq
    python313
    fontconfig

  ];

  ### =========================
  ### WSLg / Wayland 基础
  ### =========================
  hardware.graphics.enable = true;

  ### =========================
  ### 声音（system daemon）
  ### =========================
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
  };

  ### =========================
  ### Locale
  ### =========================
  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
  };

  ### =========================
  ### 输入法（system）home 级无法使用
  ### =========================

  i18n.inputMethod = {
    enabled = "fcitx5";

    fcitx5 = {
      addons = with pkgs; [
        fcitx5-rime
        fcitx5-configtool
        fcitx5-chinese-addons
      ];
    };
  };

  
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE  = "fcitx";
    XMODIFIERS    = "@im=fcitx";

    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "fcitx";

    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  ### =========================
  ### 字体（修正 Maple Mono）
  ### =========================
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      maple-mono.NF
    ];

    fontconfig.defaultFonts = {
      monospace = [ "Maple Mono NF" ];
      sansSerif = [ "Noto Sans CJK SC" ];
      serif     = [ "Noto Serif CJK SC" ];
      emoji     = [ "Noto Color Emoji" ];
    };
  };

  system.stateVersion = "25.05";
}
