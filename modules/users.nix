{
  config,
  pkgs,
  ...
}: {
  users.users.vivivi = {
    isNormalUser = true;
    description = "vivivi";
    extraGroups = [
      "networkmanager"
      "wheel"
      "home-manager"
      "flakes"
      "vpn"
      "protonvpn"
      "protonvpn-gui"
      "plugedev"
      "keyd"
      "input"
      "dialout"
      "audio"
      "video"
      "input-remapper"
      "plugdev"
      "vboxusers"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [
      kate
      librewolf
      vivaldi
      vscode
    ];
  };
}
