# Interactive Check
if status is-interactive
    # Commands to run in interactive sessions can go here

# Network Utilities
abbr myip 'curl ipinfo.io/ip'
alias wet="curl 'https://wttr.in/?format=1' | tr -d '+'"
alias da="curl 'https://wttr.in/?format=1' | tr -d '+' && date && upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage"

# System Management Aliases

## TODO: make a wrapper for (combining) 'sudo nixos-rebuild switch' and 'home-manager switch', logging all output to a logfile/s, and 
## only important info to stdout including home-manager generation and any errors that may have occured during build. work on having 
## output to stdout with Glow or something else from CharmBracelet, maybe some kind of tui load/progress bar with animated/color-changing 
## text. wrapper should do a 'git push' to backup both the '/etc/nixos' and '~/.config/home-manager' dirs and other dotfiles. for sure 
## have stdout logged to .log and .md formats.
alias nrs='sudo nixos-rebuild switch '

alias listgen='sudo nix-env --list-generations --profile /nix/var/nix/profiles/system'
alias restart='sudo reboot 0'
abbr shutdown 'sudo shutdown 0'
abbr sus 'sudo suspend 0'
abbr nixreup "sudo nixos-rebuild switch --upgrade"
abbr nixreupnof "sudo nixos-rebuild switch --upgrade --no-flake"
abbr hme "home-manager edit"
abbr hms "home-manager switch"

# Directory Navigation
alias dotfiles='cd ~/.dotfiles'
alias hoe='cd ~/.config/home-manager/'
abbr conf 'cd /home/vivivi/.config/'
abbr etc "cd /etc/nixos/"
alias clones="cd /home/vivivi/clones/"
alias ..="cd .."

# File and Process Management
alias usb='sudo cyme '
alias killall='sudo killall '
alias mkdir='mkdir -p '
alias grep='grep --color=auto '
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# System Information and Logs
alias sysctl='sudo systemctl '
alias sysfailed="systemctl list-units --failed"
alias hw="hwinfo --short"
alias jctl="journalctl -p 3 -xb"
alias lcalamares="bat /var/log/Calamares.log"
alias lxorg="bat /var/log/Xorg.0.log"
alias lxorgo="bat /var/log/Xorg.0.log.old"

# User Interface and Experience
abbr c 'clear'
abbr cl 'clear'
abbr cf 'clear & neofetch'
alias less='less -R'
alias cls='clear'
alias j="jobs"

# File Editing and Viewing
alias space="sudo spacevim "
alias emacs='sudo emacs run '
alias vis='sudo spacevim "+set si" '
alias nlxdm="sudo $EDITOR /etc/lxdm/lxdm.conf"
alias nlightdm="sudo $EDITOR /etc/lightdm/lightdm.conf"
alias ngrub="sudo $EDITOR /etc/default/grub"
alias nconfgrub="sudo $EDITOR /boot/grub/grub.cfg"
alias nmkinitcpio="sudo $EDITOR /etc/mkinitcpio.conf"
alias nsddm="sudo $EDITOR /etc/sddm.conf"
alias nsddmk="sudo $EDITOR /etc/sddm.conf.d/kde_settings.conf"
alias nfstab="sudo $EDITOR /etc/fstab"
alias nnsswitch="sudo $EDITOR /etc/nsswitch.conf"
alias nhosts="sudo $EDITOR /etc/hosts"
alias nhostname="sudo $EDITOR /etc/hostname"
alias nb="$EDITOR ~/.bashrc"
alias nz="$EDITOR ~/.zshrc"
alias nf="$EDITOR ~/.config/fish/config.fish"
alias netc="sudo nvim /etc/nixos/configuration.nix"

# Security and Permissions
alias fix-permissions="sudo chown -R $USER:$USER ~/.config ~/.local"
alias lockreset="faillock --user $USER --reset"

# Miscellaneous
alias batt="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage"
alias userlist="cut -d: -f1 /etc/passwd"
alias openports='netstat -nape --inet'
alias ipview="netstat -anpl | grep :80 | awk {'print \$5'} | cut -d\":\" -f1 | sort | uniq -c | sort -n | sed -e 's/^ *//' -e 's/ *\$//'"
alias sdi="sudo input-remapper-gtk & disown"
alias rg="rg --sort path"
alias kc='killall conky'
alias kp='killall polybar'
alias kpi='killall picom'
alias wet="curl 'https://wttr.in/29205?format=%C+%t+%w+%h&n=12'"

# Reboot and Shutdown Aliases
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'
alias ssn="sudo shutdown now"
alias sr="sudo reboot"


#alias cf='cp /etc/skel/.config/fish/config.fish ~/.config/fish/config.fish && echo "Copied."'


                   ###### Starship initialization ######
source (/home/vivivi/.nix-profile/bin/starship init fish --print-full-init | psub)

                   ###### end of initialization ######      

                   ###### Atuin init ######
set -gx ATUIN_SESSION (atuin uuid)
set --erase ATUIN_HISTORY_ID

function _atuin_preexec --on-event fish_preexec
    if not test -n "$fish_private_mode"
        set -g ATUIN_HISTORY_ID (atuin history start -- "$argv[1]")
    end
end

function _atuin_postexec --on-event fish_postexec
    set -l s $status

    if test -n "$ATUIN_HISTORY_ID"
        ATUIN_LOG=error atuin history end --exit $s -- $ATUIN_HISTORY_ID &>/dev/null &
        disown
    end

    set --erase ATUIN_HISTORY_ID
end

function _atuin_search
    set -l keymap_mode
    switch $fish_key_bindings
        case fish_vi_key_bindings
            switch $fish_bind_mode
                case default
                    set keymap_mode vim-normal
                case insert
                    set keymap_mode vim-insert
            end
        case '*'
            set keymap_mode emacs
    end

    # In fish 3.4 and above we can use `"$(some command)"` to keep multiple lines separate;
    # but to support fish 3.3 we need to use `(some command | string collect)`.
    # https://fishshell.com/docs/current/relnotes.html#id24 (fish 3.4 "Notable improvements and fixes")
    set -l ATUIN_H (ATUIN_SHELL_FISH=t ATUIN_LOG=error atuin search --keymap-mode=$keymap_mode $argv -i -- (commandline -b) 3>&1 1>&2 2>&3 | string collect)

    if test -n "$ATUIN_H"
        if string match --quiet '__atuin_accept__:*' "$ATUIN_H"
          set -l ATUIN_HIST (string replace "__atuin_accept__:" "" -- "$ATUIN_H" | string collect)
          commandline -r "$ATUIN_HIST"
          commandline -f repaint
          commandline -f execute
          return
        else
          commandline -r "$ATUIN_H"
        end
    end

    commandline -f repaint
end

function _atuin_bind_up
    # Fallback to fish's builtin up-or-search if we're in search or paging mode
    if commandline --search-mode; or commandline --paging-mode
        up-or-search
        return
    end

    # Only invoke atuin if we're on the top line of the command
    set -l lineno (commandline --line)

    switch $lineno
        case 1
            _atuin_search --shell-up-key-binding
        case '*'
            up-or-search
    end
end

bind \cr _atuin_search
bind -k up _atuin_bind_up
bind \eOA _atuin_bind_up
bind \e\[A _atuin_bind_up
if bind -M insert > /dev/null 2>&1
bind -M insert \cr _atuin_search
bind -M insert -k up _atuin_bind_up
bind -M insert \eOA _atuin_bind_up
bind -M insert \e\[A _atuin_bind_up
end
                   ###### end Atuin init ######
		   
############

                   ###### begin Zoxide init ######
# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions --query __zoxide_cd_internal
    if builtin functions --query cd
        builtin functions --copy cd __zoxide_cd_internal
    else
        alias __zoxide_cd_internal='builtin cd'
    end
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

if test -z $__zoxide_z_prefix
    set __zoxide_z_prefix 'z!'
end
set __zoxide_z_prefix_regex ^(string escape --style=regex $__zoxide_z_prefix)

# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if set -l result (string replace --regex $__zoxide_z_prefix_regex '' $argv[-1]); and test -n $result
        __zoxide_cd $result
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions.
function __zoxide_z_complete
    set -l tokens (commandline --current-process --tokenize)
    set -l curr_tokens (commandline --cut-at-cursor --current-process --tokenize)

    if test (count $tokens) -le 2 -a (count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        complete --do-complete "'' "(commandline --cut-at-cursor --current-token) | string match --regex '.*/$'
    else if test (count $tokens) -eq (count $curr_tokens); and ! string match --quiet --regex $__zoxide_z_prefix_regex. $tokens[-1]
        # If the last argument is empty and the one before doesn't start with
        # $__zoxide_z_prefix, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
        and echo $__zoxide_z_prefix$result
        commandline --function repaint
    end
end
complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

abbr --erase z &>/dev/null
alias z=__zoxide_z

abbr --erase zi &>/dev/null
alias zi=__zoxide_zi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.config/fish/config.fish):
#
#   zoxide init fish | source
                   ###### end Zoxide init ######
end

