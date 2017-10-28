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
alias v='nvim -p'
alias vim=v
alias g=git

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

# arch / centos
alias pms='sudo pm-suspend --quirks-dpms-on'

# ubuntu
alias sus='systemctl suspend'
alias apd='sudo apt update'
alias apg='sudo apt upgrade'
alias api='sudo apt install'

# "tamperproof"
alias xrandr='qdbus org.freedesktop.ScreenSaver /ScreenSaver Lock #'

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
export n='--name-status'
export u=@{u}


[ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="%d/%m/%y %T "

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

alias llz='sudo tail -f /var/log/logzilla/logzilla.log'
alias ssl='sudo tail -f /var/log/supervisor/*'
alias kaboom='sudo bin/lz5setup --armageddon kaboom --db-root-pass LZ.007f0101'

alias gg='cd ~/dev/ticket'

function hurravpn {
    echo "domain hurra
search hurra
nameserver 10.42.8.1
nameserver 8.8.8.8
nameserver 8.8.4.4
" | sudo tee /etc/resolv.conf >/dev/null
    #chattr +i /etc/resolv.conf
    sudo openvpn ~jb/hurra/vpn.pl.hurra.com.conf
    #chattr -i /etc/resolv.conf
    echo "nameserver 8.8.8.8
nameserver 8.8.4.4
" | sudo tee /etc/resolv.conf >/dev/null 
    #chattr +i /etc/resolv.conf
}

function ji {
    #FIXME handle many args
    keys=${1:-`ticket -k`}
    [ -n "$keys" ] || return
    for k in $keys; do
        xdg-open http://jira.lzil.la:8080/browse/$k
    done
}

export PYTHONPATH=$PYTHONPATH:~jb/dev/lz/lib
