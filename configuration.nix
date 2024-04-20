{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/x11.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/packages.nix
    ./modules/security.nix
    ./modules/other.nix
    ./modules/keyd.nix
    #./modules/ratpoison.nix
  ];

  system.stateVersion = "23.11";
}
