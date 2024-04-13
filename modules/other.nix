{
  config,
  pkgs,
  ...
}: {
  # Nix settings
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Qt settings
  qt.enable = true;
  qt.platformTheme = "kde";
}
