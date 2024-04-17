{
  config,
  pkgs,
  ...
}: {
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.autoNumlock = true;
  #services.xserver.displayManager.lightdm.enable = true;
  # TODO: make and config at '~/.xinitrc'
  services.xserver.displayManager.startx.enable = true;

  services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  #services.xserver.desktopManager.enlightenment.enable = true;

  # Enable other window managers
  # TODO: retrieve ratpoison config from Samsung usb
  services.xserver.windowManager = {
    awesome = {
      package = pkgs.awesome;
      enable = true;
      luaModules = [pkgs.luaPackages.vicious];
    };
  };
  services.xserver.windowManager.ratpoison.enable = true;
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.extraPackages = haskellPackages: [
    haskellPackages.xmonad-contrib
    haskellPackages.monad-logger
  ];
  services.xserver.windowManager.xmonad.enableConfiguredRecompile = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.xmonad.config = ''
    import XMonad
    import XMonad.Util.EZConfig (additionalKeys)
    import Control.Monad (when)
    import Text.Printf (printf)
    import System.Posix.Process (executeFile)
    import System.Info (arch,os)
    import System.Environment (getArgs)
    import System.FilePath ((</>))

    compiledConfig = printf "xmonad-%s-%s" arch os

    myConfig = defaultConfig
      { modMask = mod4Mask -- Use Super instead of Alt
      , terminal = "kitty" }
      `additionalKeys`
      [ ( (mod4Mask,xK_r), compileRestart True)
      , ( (mod4Mask,xK_q), restart "xmonad" True ) ]

    compileRestart resume = do
      dirs  <- asks directories
      whenX (recompile dirs True) $ do
        when resume writeStateToFile
        catchIO
            ( do
                args <- getArgs
                executeFile (cacheDir dirs </> compiledConfig) False args Nothing
            )

    main = getDirectories >>= launch myConfig

  '';

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
