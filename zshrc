# vim: set ft=sh ts=4 sw=4:
#
#   Copyright © 2013-2014 Sophie 'k4v' van Soest <linux@k4v.de>
#   All rights reserved.
#

# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load.
ZSH_THEME="wezm+"

# Exdends the PATH.
path+=/data/misc/repos/customk4v
path+=/usr/share/playframework2

# Set to this to use case-sensitive completion
CASE_SENSITIVE="false"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Defines the LS_COLORS by the /etc/dir_colors file.
eval `dircolors /etc/dir_colors`

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
#COMPLETION_WAITING_DOTS="true"

# Disables correction.
DISABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
#plugins=(git)
plugins=(archlinux gitfast rsync zsh-syntax-highlighting fasd systemd)

# Initialize the oh-my-zsh framework.
source $ZSH/oh-my-zsh.sh

## Aliases ##
# To use the default coreutils cat: "=cat". 
#alias cat="vimcat"
alias vcat="vimcat"

### Fasd plugin ###
alias v='f -t -e vim -b viminfo'
alias o='a -e xdg-open'
alias c='fasd_cd -d'

### Sudo aliases ###
sudo_aliases=(pacman pacman-key pacman-optimize pacman-db-upgrade htop killall kill nethogs modprobe rmmod lsmod modinfo lspci avrdude gparted mount umount fdisk ifconfig)
for c in $sudo_aliases; do; alias $c="sudo $c"; done

## Suffix aliases ##
alias -s coffee=coffee
alias -s js=node
alias -s php=php

### Other ###
alias feh="feh --index-info --draw-filename --keep-zoom-vp  --magick-timeout 1"
alias feh-thumb="feh -t -Sfilename -E 128 -y 128 -W 1024 -P -C /usr/share/fonts/truetype/ttf-dejavu/ -e DejaVuSans/8"
alias feh-today="feh *`date +"%F"`*"
alias rgrep="grep -Ri"
alias mpc-file="mpc --format=%file% | xargs | cut -d ' ' -f1"
alias dolphin="dolphin $PWD"
alias watch="watch --interval=0,2"
alias yaourt="yaourt --noconfirm"
alias pdfsandwich="pdfsandwich -lang deu"

## Backups ##
backupDirectory="/data/misc/backups/generic"

function backup-tar() {
	if [ "$1" != "" ]; then
#		modArguments="${1:0:1}${2:0:1}${3:0:1}${4:0:1}${5:0:1}${6:0:1}${7:0:1}${8:0:1}"
#		backupArghash=$(echo ${modArguments} | tr 'A-Z' 'a-z' | tr -d -c 'a-z0-9- ')
		echo $backupIdentifier
		echo "Enter backupIdentifier:"
		read backupIdentifier
		if [ -z "${backupIdentifier}" ]; then
			backupIdentifier="generic"
		fi
		backupDate=$(date +"%Y-%m-%d")
		backupIdentifierName="${backupDate}_${backupIdentifier}_backup"
		backupTarFileName=${backupDirectory}/${backupIdentifierName}.tar.gz
		backupInfoFileName=${backupDirectory}/${backupIdentifierName}.info.md
		backupLogFileName=${backupDirectory}/${backupIdentifierName}.log
		backupChecksumFileName=${backupDirectory}/${backupIdentifierName}.sha256sum
		backupCommand="tar -vczf ${backupTarFileName} $@"
		echo -e "# Backup: ${backupIdentifier} - ${backupDate} #\n" 	 	\
			"## Included Files and Directories at ${PWD} ##\n\t$@\n"		\
			"## Executed command ##\n\t${backupCommand}\n" 					\
			> ${backupInfoFileName}
		#exec "${backupCommand}" >> "${backupLogFileName}"
		tar -vczf ${backupTarFileName} $@
		sha256sum "${backupTarFileName}" > "${backupChecksumFileName}"
	else
		echo "example: backup directory1 directory2 file1 file2 file3, then type the backup-identifier."
	fi
}

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

alias sc-suspend-system="sudo systemctl suspend"
alias sc-reboot-system="sudo systemctl reboot"
alias sc-poweroff-system="sudo systemctl poweroff"

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
export EDITOR=vim
export PAGER=most
export BROWSER=chromium
export LESS=-cex3M
export XDG_CONFIG_HOME=~/.config 
export PULSE_SERVER=localhost
export MPD_HOST=tank
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb'
export _JAVA_AWT_WM_NONREPARENTING=1
export NODE_PATH=/usr/lib/node_modules/
export VST_PATH=/usr/lib/vst/:/usr/local/lib/vst/:~/.vst/:~/.vst-bridges/
export TERM=xterm
export SDL_JOYSTICK_DEVICE=/dev/input/js2

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

## Disable correction for specific commands ##
alias mv='nocorrect mv'      
alias cp='nocorrect cp'            
alias mkdir='nocorrect mkdir'      
alias grep='nocorrect grep  --color=always'
alias echo='nocorrect echo'
alias sudo='nocorrect sudo'
