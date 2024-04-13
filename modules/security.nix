{
  config,
  pkgs,
  ...
}: {
  # Open ports in the firewall
  networking.firewall = {
    #allowedTCPPorts = [ 24800 ];
    #allowedUDPPorts = [ 24800 ];
    enable = true;
  };

  # Security Polkit
  security.polkit.enable = true;
  security.polkit.adminIdentities = [
    "unix-group:wheel"
    "unix-user:vivivi"
    "unix-user:admin"
  ];

  # Misc security settings
  security.protectKernelImage = true;
  boot.loader.systemd-boot.editor = false;

  # Kernel sysctl settings
  boot.kernel.sysctl = {
    # Disable the Magic SysRq key
    "kernel.sysrq" = 0;

    # TCP hardening
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_rfc1337" = 1;

    # TCP optimization
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };

  # Enable TCP BBR kernel module
  boot.kernelModules = ["tcp_bbr"];
}
