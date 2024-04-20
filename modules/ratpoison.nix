{
  config,
  lib,
  pkgs,
  ...
}: let
  ratpoisonrc = pkgs.writeText "ratpoisonrc" ''
    # ratpoison config file at ~/.ratpoisonrc

    #exec xmodmap -e "keycode 133 = F30"

    #exec xsetroot -cursor_name left_ptr

    # exec gnome-settings-daemon
    exec lxpolkit
    exec sudo keyd
    exec xfsettingsd
    #exec kitty
    #exec kitty nmtui-connect
    exec nitrogen --restore

    ###################################################################
    # RATPOISON MISC.

    escape C-y
    swap t
    unbind x
    bind Escape abort

    bind x exec rofi -show drun
    bind C-x swap
    bind C-R exec pkill -HUP ratpoison
    bind semicolon colon
    bind colon exec
    bind b prev
    bind equal time
    bind q only

    ####################################################################
    # VIRTUAL DESKS
    gnewbg one
    gnewbg two

    definekey top M-l exec ratpoison -c "select -" -c "gprev" -c "next"
    definekey top M-h exec ratpoison -c "select -" -c "gnext" -c "next"

    # Switch between windows
    definekey top M-j next
    definekey top M-k prev

    ####################################################################
    # GROUPS/FRAMES

    bind Delete gdelete
    bind Insert gnew 2
    bind bracketright exec ratpoison -c "gnext" -c "other"
    bind bracketleft exec ratpoison -c "gprev" -c "other"
    bind backslash gmove
    bind End groups

    ####################################################################
    # APPS

    bind X exec i3lock-fancy -p
    #REMOVE# bind o exec opera
    bind f exec dolphin
    bind c exec kitty
    #bind C exec alacritty

    ####################################################################
    # RUDENESS
    #rudeness is a bitwise or of the following values:
    # 1    Transient windows may raise.
    # 2    Normal windows may raise.
    # 4    New transient windows end up in the foreground.
    # 8    New normal windows end up in the foreground.
    rudeness 13
    warp off

    ####################################################################
    # WINDOW MISC

    set winname title
    set wingravity center
    set transgravity center
    set border 5
    #set barborder 3
    #fails hard on multi-monitor. Do this manually
    set padding 0 0 0 0
    set barpadding 10 10
    set inputwidth 800
    set bargravity center
    set font 0xProto Nerd Font
    set font "0xProto Nerd Font:size=10"
    set bgcolor #2f2f2f
    set fgcolor #418CDD
    set fwcolor #418CDD
    set bwcolor #2f2f2f

    ####################################################################
    # # Display formats
    set infofmt %c: %t [%n]
    set framefmt %t [%n]

    # Blank Monitor
    #bind grave exec xset dpms force off
    bind l exec xlock
    bind M-l exec xlock

    alias dunst exec dunst
    bind C-1 dunst

    # Sticky Windows
    bind d dedicate

    # Undo
    bind u undo

    bind e exec emacs

    definekey top M-h hsplit
    definekey top M-v vsplit
    definekey top M-. colon

    # Printscreen!
    #definekey top Print exec mkdir ~/snapshots/; import -window root ~/snapshots/`date +%Y%m%d%H%M%S`.png
    # make a screenshot
    alias sshot exec scrot ~/screenshot-ratpoison-`date +%F`.png
    bind Print sshot
    # Date/Time
    bind C-a exec ratpoison -c "echo `date +'%r - %A %n    %D - %B'`  `cal | tail -n +2 | sed -e 's/^Su/\n\n Su/' -e 's/.*/ & /' -e \"s/\ $(date +%e) /\<$(date +%e)\>/\"`"
    bind C-s exec date +'%a %b %d %I:%M%p'
    bind C-d exec ratpoison -c "echo 'da | glow'"

    # Volume
    definekey top S-XF86AudioRaiseVolume exec ratvolume Master 3%+
    definekey top S-XF86AudioMute exec ratvolume Master 0
    definekey top S-XF86AudioLowerVolume exec ratvolume Master 3%-
    definekey top XF86AudioRaiseVolume exec ratvolume PCM 3%+
    definekey top XF86AudioMute exec ratvolume PCM 0
    definekey top XF86AudioLowerVolume exec ratvolume PCM 3%-

    definekey top s-Up exec ratvolume PCM 3%+
    definekey top s-Down exec ratvolume PCM 3%-
    definekey top s-S-Up exec ratvolume Master 3%+
    definekey top s-S-Down exec ratvolume Master 3%-

    # Focus
    definekey top M-Tab next
    definekey top M-ISO_Left_Tab prev

    # Navigation
    definekey top C-S-Up focusup
    definekey top C-S-Left focusleft
    definekey top C-S-Down focusdown
    definekey top C-S-Right focusright
    definekey top s-Left prevscreen
    definekey top s-Right nextscreen


    # Workspaces
    exec rpws init 4 -a
    definekey top C-M-1 rpws1
    definekey top C-M-2 rpws2
    definekey top C-M-3 rpws3
    definekey top C-M-4 rpws4
    definekey top C-M-Left rpwsp
    definekey top C-M-Right rpwsn

    # Startup crap

    #exec sudo keyd
    sselect 1
    #set padding 0 20 0 0
    exec killall xfce4-notifyd
    #exec dunst
    exec conky -c $HOME/.conkyrc-rat |dzen2 -h 20 -ta l -e -p
    # tmpwm stumpwm
  '';
in {
  options = {
    services.xserver.windowManager.ratpoison.enable = lib.mkEnableOption "Ratpoison Window Manager";
  };

  config = lib.mkIf config.services.ratpoison.enable {
    environment.etc."ratpoison/ratpoisonrc".source = ratpoisonrc;

    services.ratpoison.package = pkgs.ratpoison;
  };
}
