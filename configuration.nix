{
  config,
  pkgs,
  ...
}: {
  imports = [
    #./hmmodules/user.nix
    ./hardware-configuration.nix
    ./home.nix
    ./modules/system.nix
    ./modules/x11.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/packages.nix
    ./modules/security.nix
    ./modules/other.nix
    ./modules/keyd.nix
  ];

  system.stateVersion = "23.11";

  # Services
  #services.snort.enable = true;

  # Qt settings
  qt.enable = true;
  qt.platformTheme = "kde";
}
