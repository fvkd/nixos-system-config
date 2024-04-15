{
  config,
  pkgs,
  ...
}: {
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define system hostname
  networking.hostName = "sixsixsix";

  # Enable network manager
  networking.networkmanager.enable = true;

  # Set your time zone
  time.timeZone = "America/New_York";

  # Select internationalization properties
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Automatic system upgrade
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flags = [
      "--update-input"
      "nixospkgs"
      "-L"
    ];
    dates = "9:00";
    randomizedDelaySec = "45min";
  };

  # Enable Keyd service
  # Find out what's enabling this at boot time before logging in for reproducibility
  services.keyd.enable = true;

  # Enable Fish shell
  programs.fish.enable = true;

  # Enable automatic garbage-collection
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 2d";
}
