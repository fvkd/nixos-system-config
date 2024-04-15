{
  config,
  pkgs,
  ...
}: {
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  #services.xserver.displayManager.lightdm.enable = true;
  # TODO: make and config at '~/.xinitrc'
  services.xserver.displayManager.startx.enable = true;

  services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  #services.xserver.desktopManager.enlightenment.enable = true;

  # Enable other window managers
  # TODO: retrieve ratpoison config from Samsung usb
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
