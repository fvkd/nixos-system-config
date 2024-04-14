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
  ];

  system.stateVersion = "23.11";
}
