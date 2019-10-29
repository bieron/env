# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

alias ls='ls --color=auto'
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -l'

alias a=ag
alias s='ssh -A'
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
alias py3=python3
alias hin='sudo hamachi login'
alias hout='sudo hamachi logout'
alias hh='for s in stop start; do sudo /etc/init.d/logmein-hamachi $s; done; sleep 1; hout; sleep 1; hin'
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
    subst=$1
    shift
    perl -i -pe "$subst" $@
}

EDITOR=nvim
VISUAL=nvim

# git goodies
alias g=git
j="--author $USER"
export n='--name-status'

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
    export PS1='\w# '
else
    [ $DISPLAY ] && export PS1='\w '
fi

alias gg='cd ~/dev/ticket'
alias tt=ticket

alias T='tput reset'
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

# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
export PYTHONSTARTUP=~/.pystartup

# Run 'fff' with 'f' or whatever you decide to name the function.
f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

alias vs='v $(g status -suno --porcelain|awk "{print \$2}")'

PATH=/home/jb/perl5/bin:$PATH:/home/jb/go/bin; export PATH;
PERL5LIB="/home/jb/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/jb/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/jb/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/jb/perl5"; export PERL_MM_OPT;

[ -e ~/.dircolors ] && eval `dircolors ~/.dircolors`
alias fd=fdfind
alias c=cd
alias r='rm -r'

function blamer {
    grep $@ -R --line-number 2>/dev/null|cut -d: -f1,2|tr ':' ' ' \
        |while read f l; do
            git blame $f -L$l,$l --porcelain 2>/dev/null|sed -n 's/^author //p';
        done|sort|uniq -c|sort -rn
}
