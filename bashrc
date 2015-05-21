# If not running interactively, don't do anything
[[ $- != *i* ]] && return
transset-df -a .9 &>/dev/null

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -l'
alias s=ssh
alias v='vim -p'
alias g=git
alias pms='sudo pm-suspend --quirks-dpms-on'
alias gr='grep -Isnr'

EDITOR=vim
VISUAL=vim
PS1='\w\$ '

. /usr/share/bash-completion/bash_completion
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

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
