{
  config,
  pkgs,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Development tools
    alejandra
    cmake
    direnv
    gcc
    gh
    git
    meson
    nixfmt-classic
    nixpkgs-fmt
    pkg-config
    poetry
    python311Full
    rustup

    # System utilities
    alacritty
    appimage-run
    atuin
    barrier
    bluez
    bluez-tools
    ckb-next
    curl
    elasticsearch
    #etcher
    eza
    feh
    fh
    fzf
    iw
    kitty
    lsd
    lxappearance
    lxde.lxsession
    nerdfonts
    nh
    nix-index
    nmap
    nmapsi4
    pasystray
    ripgrep
    rofi
    rofi-bluetooth
    sutils
    swaybg
    sysz
    usbutils
    xsel
    xlockmore
    xdo
    wget
    vuze

    # Hyprland desktop environment
    hyprdim
    hyprnome
    hyprlock
    hyprlang
    hyprkeys
    hypridle
    hyprshade
    hyprpaper
    hyprland-protocols
    hyprlandPlugins.hy3
    hyprland-per-window-layout
    hyprland-autoname-workspaces
    nwg-bar
    nwg-menu
    nwg-look
    nwg-dock
    nwg-panel
    nwg-drawer
    nwg-wrapper
    nwg-displays
    nwg-launchers
    nwg-dock-hyprland
    nwg-dock-hyprland
    waylogout
    wlroots
    yambar-hyprland-wses
    xdg-desktop-portal-hyprland

    # Security and VPN
    keyd
    maltego
    protonvpn-gui

    # Editors and IDEs
    meld
    spacevim
    xfce.catfish
    xfce.thunar
  ];
}
