# If not running interactively, don't do anything
#[[ $- != *i* ]] && return
[[ -z "$PS1" ]] && return
#transset-df -a .9 &>/dev/null

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias gr="grep -Isnr --exclude='*~'"
alias pgr="grep -P --exclude='*~' -Isnr"

alias ls='ls --color=auto'
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -l'

alias s=ssh
alias v='vim -p'
alias g=git

alias pms='sudo pm-suspend --quirks-dpms-on'

alias mk='mkdir'
alias mkd='mkdir -pv' #creates dir
alias diff='colordiff'
alias ..='cd ..'
alias wget='wget -c' #resume last download
alias ports='netstat -tulanp'

alias perlsyn='for f in `git diff --name-only|grep pm$`; do echo; echo $f; perl -cIlib $f; done'
alias pe=perl
alias py=python

#grep for files
function gf {
    DIR=${2:-.}
    find $DIR -ipath "*$1*" 
}

EDITOR=vim
VISUAL=vim

export n='--name-status'
export u=@{upstream}
alias xrandr='qdbus org.freedesktop.ScreenSaver /ScreenSaver Lock #'

if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

export PATH=$PATH:$HOME/bin:$HOME/perl/bin:$HOME/`hostname`_bin

HOST_BASHRC=~/.`hostname`.bashrc
[ -f $HOST_BASHRC ] && . $HOST_BASHRC

if [ `whoami` = root ]; then
    #export PS1='%B%~%b$%#'
    export PS1="\w# "
else
    [ $DISPLAY ] && export PS1='\w ' #PS1 is set in bash_profile
fi
