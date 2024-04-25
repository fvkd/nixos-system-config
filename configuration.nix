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
    #./modules/keyd.nix
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    keyd = pkgs.keyd.overrideAttrs (oldAttrs: rec {
      version = "2.4.2";
      src = pkgs.fetchFromGitHub {
        owner = "rvaiya";
        repo = "keyd";
        rev = "v${version}";
        sha256 = "1062jdr716sa0srbvig65d10km7dmvb35mjnd2cjq1maxwwilzl72";
      };
    });
  };

  system.stateVersion = "23.11";
}
