{
  config,
  pkgs,
  ...
}: {
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Touchpad configuration
  services.xserver.libinput = {
    touchpad = {
      accelSpeed = "1.0";
      tappingDragLock = true;
      naturalScrolling = false;
      clickMethod = "clickfinger";
      tapping = true;
      disableWhileTyping = true;
      scrollMethod = "twofinger";
      horizontalScrolling = true;
    };
    enable = true;
  };

  # Atuin configuration
  services.atuin = {
    maxHistoryLength = 200000;
    host = "127.0.0.1";
    enable = true;
    openFirewall = true;
  };

  # Emacs configuration
  services.emacs = {
    package = pkgs.emacs-gtk;
    enable = true;
    startWithGraphical = true;
    install = true;
  };

  # Enable the KDE Plasma Desktop Environment
  services.xserver.displayManager = {
    sddm.enable = true;
    startx.enable = true;
  };
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable other window managers
  services.xserver.windowManager = {
    awesome = {
      package = pkgs.awesome;
      enable = true;
      luaModules = [pkgs.luaPackages.vicious];
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
