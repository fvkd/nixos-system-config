{pkgs, ...}: {
  # Install keyd package
  environment.systemPackages = [pkgs.keyd];

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

    *

    #04f3:0080

    [main]

    #leftshift = overload(shift, backspace)
    rightshift = overload(shift, enter)
    #meta = oneshot(meta)
    meta = macro(C-y)
    control = oneshot(control)

    leftalt = oneshot(alt)
    rightalt = oneshot(altgr)

    capslock = overload(control, esc)

    sysrq = backslash

    wakeup = macro(C-y !)

    escape = `

    ` = backspace

    #rightmouse = backspace

    #middlemouse = enter
  '';
}
