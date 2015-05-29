# If not running interactively, don't do anything
#[[ $- != *i* ]] && return
[[ -z "$PS1" ]] && return
#transset-df -a .9 &>/dev/null

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias gr='grep -Isnr'
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

EDITOR=vim
VISUAL=vim

export n='--name-only'

. /usr/share/bash-completion/bash_completion
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

HOST_SPECIFIC=.bash_`hostname`
[ -x $HOST_SPECIFIC ] && . $HOST_SPECIFIC

if [ `whoami` = root ]; then
    #export PS1='%B%~%b$%#'
    export PS1="\w# "
else
    [ $DISPLAY ] && export PS1='\w ' #PS1 is set in bash_profile 
fi

#color in man
#LESS_TERMCAP_mb='E[01;31m'
#LESS_TERMCAP_md='E[01;38;5;74m'
#LESS_TERMCAP_me='E[0m'
#LESS_TERMCAP_se='E[0m'
#LESS_TERMCAP_so='E[38;5;246m'
#LESS_TERMCAP_ue='E[0m'
#LESS_TERMCAP_us='E[04;38;5;146m'
#
##because root links ~jb/.bashrc
##if [ $USER = jb ]; then
##
##fi
#man() {
#    env LESS_TERMCAP_mb=$'\E[01;31m' \
#        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
#        LESS_TERMCAP_me=$'\E[0m' \
#        LESS_TERMCAP_se=$'\E[0m' \
#        LESS_TERMCAP_so=$'\E[38;5;246m' \
#        LESS_TERMCAP_ue=$'\E[0m' \
#        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
#        man "$@"
#}
