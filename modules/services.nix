{
  config,
  pkgs,
  ...
}: {
  # Printing configuration
  services.printing.enable = false;

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
}
