# vim: set ft=sh ts=4 sw=4:
#
#   Copyright © 2013-2016 Sophie van Soest <sophie@entropie.rocks>
#   All rights reserved.
#

# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load.
ZSH_THEME="bullet-train"

# Configurates the zsh-theme by hostname.
case $(hostname) in
 neo) 
	BULLETTRAIN_DIR_BG="48"
	BULLETTRAIN_DIR_FG="0"
	;;
 tank) 
	BULLETTRAIN_DIR_BG="44"
	BULLETTRAIN_DIR_FG="0"
	;;
 morphberry) 
	BULLETTRAIN_DIR_BG="162"
	BULLETTRAIN_DIR_FG="15"
	BULLETTRAIN_GIT_SHOW=false
	;;
 *)	
	BULLETTRAIN_DIR_BG="48"
	BULLETTRAIN_DIR_FG="0"
	;;
esac

# Sets other theme colors.
BULLETTRAIN_TIME_BG="234"
BULLETTRAIN_TIME_FG="246"
BULLETTRAIN_STATUS_BG="8"
BULLETTRAIN_CONTEXT_DEFAULT_USER="sophie"

# Exdends the PATH.
PATH+=/usr/share/playframework2
PATH+=:/usr/bin/vendor_perl

# Set to this to use case-sensitive completion
CASE_SENSITIVE="false"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Defines the LS_COLORS by the /etc/dir_colors file.
eval `dircolors ~/.dir_colors`

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
#COMPLETION_WAITING_DOTS="true"

# Disables correction.
DISABLE_CORRECTION="true"

# Sets the path for custom framework stuff.
ZSH_CUSTOM=$HOME/.zsh_custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(archlinux gitfast rsync zsh-syntax-highlighting fasd systemd history-substring-search)

# Initialize the oh-my-zsh framework.
source $ZSH/oh-my-zsh.sh

## Aliases ##
# To use the default coreutils cat: "=cat". 
alias vcat="vimcat"

### Progress for dd (since coreutils-8.24) ###
alias dd='dd status=progress '

### Replace vim with nvim. ###
alias vim="nvim"

### Fasd plugin ###
alias v='f -t -e nvim'
alias o='a -e xdg-open'
alias c='fasd_cd -d'

### Sudo aliases ###
sudo_aliases=(pacman pacman-key pacman-optimize pacman-db-upgrade htop killall kill pkill nethogs modprobe rmmod lsmod modinfo lspci avrdude gparted mount umount fdisk hdparm ifconfig ip netctl pip pip2)
for c in $sudo_aliases; do; alias $c="sudo $c"; done

## Suffix aliases ##
alias -s coffee=coffee
alias -s js=node
alias -s php=php

### Other ###
alias feh="feh --index-info --draw-filename --keep-zoom-vp  --magick-timeout 1"
alias feh-thumb="feh -t -Sfilename -E 128 -y 128 -W 1024 -P -C /usr/share/fonts/truetype/ttf-dejavu/ -e DejaVuSans/8"
alias feh-today="feh *`date +"%F"`*"
alias rgrep="grep -Rinw"
alias mpc-file="mpc --format=%file% | xargs | cut -d ' ' -f1"
alias watch="watch --interval=0,2"
alias yaourt="yaourt --noconfirm"
alias pdfsandwich="pdfsandwich -lang deu"
alias kirschkuchen='7z a -t7z -m0=LZMA -mmt=on -mx=9 -md=96m -mfb=256'
alias generate-password="head -c 32 /dev/urandom | base64 | head -c 32"
alias pip-upgrade-review="sudo pip-review --local --auto"
alias pip-upgrade-freeze="sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"

## Helper ##
function cat-which() {
	if [ "$1" != "" ]; then
		cat $(which $1)
	fi
}
function vim-which() {
	if [ "$1" != "" ]; then
		vim $(which $1)
	fi
}
function mpc-spotify-uri() {
	mpc insert "$1" && mpc next
}

## Systemd ##
function journal() {
	if [ "$1" != "" ]; then
		sudo journalctl _COMM=$1 -f -n 500
	else
		sudo journalctl -f -n 500
	fi
}
function journalUser() {
	if [ "$1" != "" ]; then
		journalctl --user _COMM=$1 -f -n 500
	else
		journalctl --user -f -n 500
	fi
}

function systemctl-restart() {
	if [ "$1" != "" ]; then
		systemctl $1 restart $2 & 
		journal $2
	fi
}

alias sc-suspend="sudo systemctl suspend"
alias sc-reboot="sudo systemctl reboot"
alias sc-poweroff="sudo systemctl poweroff"

## Systemd-plugin fork for handling user sessions.
systemd_usersession_commands=(
  list-units is-active status show help list-unit-files
  is-enabled list-jobs show-environment
  start stop reload restart try-restart isolate kill
  reset-failed enable disable reenable preset mask unmask
  link load cancel set-environment unset-environment
)
for c in $systemd_usersession_commands; do; alias scu-$c="systemctl --user $c"; done

## My completions ##
okular() { command okular ${*:-*.pdf(om[1])} } 
zstyle ':completion:*:*:okular:*' menu yes select
zstyle ':completion:*:*:okular:*' file-sort time 

#file() { command file ${*:*} }
#zstyle ':completion:*:*:file:*' menu yes select
#zstyle ':completion:*:*:file:*' file-sort time

# Sorts all files by time.
zstyle ':completion:*:*' file-sort time

# Sets the colors of completion by $LS_COLORS.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

## Environment ##
export EDITOR=nvim
export PAGER=most
export BROWSER=chromium
export LESS=-cex3M
export XDG_CONFIG_HOME=~/.config 
export PULSE_SERVER=localhost
export MPD_HOST=tank
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb'
export _JAVA_AWT_WM_NONREPARENTING=1
export NODE_PATH=/usr/lib/node_modules/
export VST_PATH=/usr/lib/vst/:/usr/local/lib/vst/:~/.vst/:~/.wine32vst/drive_c/vst
export TERM=xterm
export SDL_JOYSTICK_DEVICE=/dev/input/js2
export QT_QPA_PLATFORMTHEME='qt5ct'

# Activates 256 colors on xterm.
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

## Nvidia threading ##
#export LD_PRELOAD="/usr/lib/libpthread.so.0 /usr/lib/libGL.so.1" 
#export __GL_THREADED_OPTIMIZATIONS=1

### Proxy ###
export no_proxy=localhost,127.0.0.1,192.168.42.1,vpn.phcn.de,intranet.phcn.de,intern.phcn.de,ip.k4v.de,ip.k4v.de:8086,tomato,192.168.1.1,192.168.1.2
export http_proxy=
export https_proxy=
#export http_proxy=http://tank:3128
#export https_proxy=http://tank:3128

## Keybindings ##
bindkey "^[[3A"  history-beginning-search-backward
bindkey "^[[3B"  history-beginning-search-forward
bindkey -s '^B' " &\n"
bindkey "^[[2~" yank                    # Insert
bindkey "^[[3~" delete-char             # Del
bindkey "^[[5~" up-line-or-history      # PageUp
bindkey "^[[6~" down-line-or-history    # PageDown
bindkey "^[e"   expand-cmd-path         # C-e for expanding path of typed command.
bindkey "^[[A"  up-line-or-search       # Up arrow for back-history-search.
bindkey "^[[B"  down-line-or-search     # Down arrow for fwd-history-search.
bindkey " "     magic-space             # Do history expansion on space.

bindkey ';5D' emacs-backward-word       # Ctrl + left cursor
bindkey ';5C' emacs-forward-word        # Ctrl + right cursor

bindkey ';5A' up-line-or-history        # Ctrl + up cursor
bindkey ';5B' down-line-or-history      # Ctrl + down cursor
bindkey ';2A' up-line-or-history        # Shift + up cursor
bindkey ';2B' down-line-or-history      # Shift + down cursor

bindkey -M emacs '^[[3;5~' kill-word    # Ctrl + backspace

case $TERM in
        xterm*)
        # Pos1 && End
        bindkey '^[OH'  beginning-of-line                  ## Pos1
        bindkey '^[OF'  end-of-line                        ## End
        bindkey '^[[3~' delete-char                        ## Entf
        bindkey '^[[5~' history-beginning-search-backward  ## Page Up
        bindkey '^[[6~' history-beginning-search-forward   ## Page Down
        ;;
        screen*)
        # Pos1 && End
        bindkey '^[[1~' beginning-of-line                  ## Pos1
        bindkey '^[[4~' end-of-line                        ## End
        bindkey '^[[3~' delete-char                        ## Entf
        bindkey '^[[5~' history-beginning-search-backward  ## Page Up
        bindkey '^[[6~' history-beginning-search-forward   ## Page Down
        ;;
esac
