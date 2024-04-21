{pkgs, ...}: {
  # Install keyd package
  environment.systemPackages = [
    (pkgs.keyd.overrideAttrs (oldAttrs: {
      version = "2.4.2";
      src = pkgs.fetchurl {
        url = "https://github.com/rvaiya/keyd/archive/refs/tags/v2.4.2.tar.gz";
        sha256 = "877e1a39efaa062c996856d632d6aeedd409422be6c5bdb2064a9b707293c280";
      };
    }))
  ];

  # Create keyd group
  users.groups.keyd.name = "keyd";

  # Create systemd service
  systemd.services.keyd = {
    description = "key remapping daemon";
    requires = ["local-fs.target"];
    after = ["local-fs.target"];
    wantedBy = ["sysinit.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.keyd}/bin/keyd";
      # Restart = "on-failure";
    };
  };

  # Enable Keyd service
  # Find out what's enabling this at boot time before logging in for reproducibility
  #services.keyd.enable = true;

  # Add quirks to make touchpad's "disable-while-typing" work properly
  environment.etc."libinput/local-overrides.quirks".text = ''
    [keyd]
    MatchUdevType=keyboard
    MatchVendor=0xFAC
    AttrKeyboardIntegration=internal
  '';

  # Configuration for keyd
  environment.etc."keyd/default.conf".text = ''
    [ids]

    0001:0001
      #leftshift = overload(shift, backspace)
      rightshift = overload(shift, enter)
      #meta = oneshot(meta)
      meta = macro(C-y)
      #control = oneshot(control)

      leftalt = oneshot(alt)
      rightalt = oneshot(altgr)

      capslock = overload(control, esc)

      sysrq = backslash

      wakeup = !

      escape = `

      ` = backspace

    05ac:024f
      leftmeta = oneshot(leftalt)
      leftalt = macro(C-y)
      capslock = overload(control, esc)



    #04f3:0080

    [main]

    #rightmouse = backspace

    #middlemouse = enter
  '';
}
