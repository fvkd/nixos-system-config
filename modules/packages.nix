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
    libstdcxx5
    meson
    nil
    nixd
    nixfmt-classic
    nixpkgs-fmt
    pkg-config
    poetry
    python311Full
    python311Packages.xlib
    python311Packages.dbus-python
    rustup

    # System utilities
    alacritty
    appimage-run
    atuin
    barrier
    bitwarden-desktop
    bitwarden-cli
    bluez
    bluez-tools
    ckb-next
    conky
    curl
    deluge
    dzen2
    elasticsearch
    #etcher
    eza
    feh
    fh
    fzf
    glow
    iw
    jq
    kitty
    lsd
    lxappearance
    lxde.lxsession
    nerdfonts
    nh
    nix-index
    nix-output-monitor
    nvd
    pasystray
    ripgrep
    rofi
    rofi-bluetooth
    sutils
    swaybg
    sysz
    upower
    usbutils
    unzip
    #vlc
    xidlehook
    xclip
    xsel
    xlockmore
    xdo
    xdotool
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
    polybar
    waylogout
    wlroots
    yambar-hyprland-wses
    xdg-desktop-portal-hyprland

    # Security and VPN
    airgeddon
    bettercap
    hcxtools
    hcxdumptool
    maltego
    mdk4
    nmap
    nmapsi4
    nuclei
    nuclei-templates
    protonvpn-cli
    protonvpn-gui
    #termshark
    #tshark
    #wireshark
    wifite2

    # Editors and IDEs
    meld
    spacevim
    xfce.catfish
    xfce.thunar
  ];
}
