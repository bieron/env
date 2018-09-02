# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

alias ls='ls --color=auto'
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -l'

alias s=ssh
alias v='nvim -p'
alias vim='nvim -p'
alias dv='docker volume'
alias dn='docker network'
alias dps='docker ps -a'
alias dr="docker run --rm -ti"
alias dl="docker ps -lq"

[ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
_completion_loader _docker
complete -F _docker d
alias d=docker
_completion_loader git
complete -o bashdefault -o default -o nospace -F _git g

alias mk='mkdir'
alias mkd='mkdir -pv' #creates dir
#alias diff='colordiff'
alias ..='cd ..'
alias wget='wget -c' #resume last download
alias ports='netstat -tulanp'
alias perlsyn='for f in `git diff --name-only|grep pm$`; do echo; echo $f; perl -cIlib $f; done'
alias pe=perl
alias py=python
alias hin='sudo hamachi login'
alias hout='sudo hamachi logout'
alias hh='hout; sleep 1; hin'
alias resolv='getent hosts'

# arch / centos
alias pms='sudo pm-suspend --quirks-dpms-on'

# ubuntu
alias sus='systemctl suspend'
alias apd='sudo apt update'
alias apg='sudo apt upgrade'
alias api='sudo apt install'
alias apr='sudo apt remove'
alias apu='sudo apt autoremove'
function aps {
    apt show $@ 2>/dev/null|perl -ne '/Description/ .. /^$/ and print'
}

#grep for files
function gf {
    DIR=${2:-.}
    find $DIR -ipath "*$1*"
}
#alias dienotest='perl -i -pe "s/(?=use Test::Deep::NoTest)/die;/" `git ls-files`'
function inplace {
    perl -i -pe "$1" `git ls-files $2`
}

EDITOR=nvim
VISUAL=nvim

# git goodies
alias g=git
od=origin/devel
ot=origin/testing
os=origin/staging
om=origin/master
j="--author $USER"
export n='--name-status'
export u=@{u}

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="%d/%m/%y %T "

shopt -s histappend

# if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#     export TERM='xterm-256color'
# else
#     export TERM='xterm-color'
# fi


HOST_BASHRC=~/.`hostname`.bashrc
[ -f $HOST_BASHRC ] && . $HOST_BASHRC

if [ $UID -eq 0 ]; then
    #export PS1='%B%~%b$%#'
    export PS1="\w# "
else
    [ $DISPLAY ] && export PS1='\w '
fi

alias gg='cd ~/dev/ticket'
alias tt=ticket

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'''
# function din {
#     docker exec -it $1 ${2:-/bin/bash}
# }
# function did {
#     docker ps -a | ag ${1:-' '} | cut -f1 -d' '
# }

alias encrypt='openssl enc -aes-256-cbc -salt -in'
alias decrypt='openssl enc -d -aes-256-cbc -salt -in'

export PATH=$PATH:~/bin:~/dev/ticket/scripts
