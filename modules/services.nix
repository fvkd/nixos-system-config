{
  config,
  pkgs,
  ...
}: {
  # Printing configuration
  services.printing.enable = false;

  # Touchpad configuration
  services.xserver.libinput = {
    touchpad = {
      accelSpeed = "1.0";
      tappingDragLock = false;
      naturalScrolling = false;
      clickMethod = "none";
      tapping = false;
      disableWhileTyping = true;
      scrollMethod = "twofinger";
      horizontalScrolling = true;
    };
    enable = true;
  };

  # ACPID
  services.acpid.enable = true;

  # Enable input-remapper
  services.input-remapper.enable = false;

  # Sound configuration
  sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    ckb-next.enable = true;
  };
  security.rtkit.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Pipewire configuration
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this:
    #jack.enable = true;
  };

  # Enable Blueman Bluetooth service
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [bluez bluez-tools];
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    #package = pkgs.bluez5-experimental;
    package = pkgs.bluez;
    settings.Policy.AutoEnable = "true";
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Name = "Hello";
      ControllerMode = "dual";
      FastConnectable = "true";
      Experimental = "true";
      KernelExperimental = "true";
    };
  };

  # Atuin configuration
  services.atuin = {
    maxHistoryLength = 200000;
    host = "127.0.0.1";
    enable = true;
    openFirewall = true;
  };

  # Emacs configuration
  # TODO: Edit to configure for Doom Emacs
  services.emacs = {
    package = pkgs.emacs-gtk;
    enable = true;
    startWithGraphical = true;
    install = true;
  };
}
