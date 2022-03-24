# If not running interactively, don't do anything
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -l'

alias a=ag
alias aa='ag --nonumbers --nofilename'
alias j=jq
alias s='ssh -A'
alias v='nvim -p'
alias vim='nvim -p'
alias dv='docker volume'
alias dn='docker network'
alias dps='docker ps -a'
alias dr="docker run --rm -ti"
alias dl="docker ps -lq"
alias cal='ncal -b'
alias add='paste -s -d+|bc'
alias m='PAGER=most man'
alias fin='tail -n1'
alias hed='head -n1'

[ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
alias d=docker
if [ -f /usr/share/bash-completion/completions/docker ]; then
  . /usr/share/bash-completion/completions/docker
  # _completion_loader _docker
  complete -F _docker d
fi

alias k=kill

alias mk='mkdir'
alias mkd='mkdir -pv' #creates dir
#alias diff='colordiff'
alias ..='cd ..'
alias wget='wget -c' #resume last download
function ports() {
  sudo netstat -tulanp | grep ${1:-''}
}
# alias perlsyn='for f in `git diff --name-only|grep pm$`; do echo; echo $f; perl -cIlib $f; done'
alias pe=perl
alias py=python3
alias p=python3
alias n=node
# alias hin='sudo hamachi login'
# alias hout='sudo hamachi logout'
# alias hh='for s in stop start; do sudo /etc/init.d/logmein-hamachi $s; done; sleep 1; hout; sleep 1; hin'
alias rslv='getent hosts'

# arch / centos
# alias pms='sudo pm-suspend --quirks-dpms-on'

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
  find ${2:-.} -ipath "*$1*"
}
function inplace {
  perl -i -pe "s/$1/$2/g" `ag -l "$1"`
}

EDITOR=nvim
VISUAL=nvim

# git goodies
alias g=git
if [ -f /usr/share/bash-completion/completions/git ]; then
  . /usr/share/bash-completion/completions/git
  complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g
fi
j="--author $USER"
export n=--name-status

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
   export PS1='\w# '
   ps1=$PS1
fi
if [ $DISPLAY ]; then
  __prompt_command() {
    local rc="$?"
    if [ $rc != 0 ]; then
      PS1='\[\e[0;31m\]'$rc'\[\e[0m\] \w '
    else
      PS1='\w '
    fi
  }
fi
PROMPT_COMMAND=__prompt_command

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

function vd {
  v `git diff ${1:-origin/master}... --name-only --diff-filter=RAM`
}
function va {
  v `ag -wl $@`
}
function vag {
  v `ag -l "$@"`
}
function vsh {
  v `git sh --name-only --pretty= "$@"`
}

PATH=/home/jb/perl5/bin:$PATH:/home/jb/go/bin; export PATH;
PERL5LIB="/home/jb/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/jb/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/jb/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/jb/perl5"; export PERL_MM_OPT;

[ -e .dircolors ] && eval `dircolors .dircolors`
alias fd=fdfind
alias c=cd
alias r='rm -r'

function blamer {
  grep $@ -R --line-number 2>/dev/null|cut -d: -f1,2|tr ':' ' ' \
    |while read f l; do
      git blame $f -L$l,$l --porcelain 2>/dev/null|sed -n 's/^author //p';
    done|sort|uniq -c|sort -rn
}

alias napi='napi.sh scan -Cutf-8 -L PL'
function pogoda {
  curl v2.wttr.in/$1
}

alias li='shuf -n1'
# alias feh="feh --action1 'echo %F | xclip -i'"
# alias feh=imv-wayland
alias :o='echo "⢀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⣠⣤⣶⣶
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⢰⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣀⣀⣾⣿⣿⣿⣿
⣿⣿⣿⣿⣿⡏⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿
⣿⣿⣿⣿⣿⣿⠀⠀⠀⠈⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠁⠀⣿
⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠙⠿⠿⠿⠻⠿⠿⠟⠿⠛⠉⠀⠀⠀⠀⠀⣸⣿
⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣴⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⢰⣹⡆⠀⠀⠀⠀⠀⠀⣭⣷⠀⠀⠀⠸⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠈⠉⠀⠀⠤⠄⠀⠀⠀⠉⠁⠀⠀⠀⠀⢿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⢾⣿⣷⠀⠀⠀⠀⡠⠤⢄⠀⠀⠀⠠⣿⣿⣷⠀⢸⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⡀⠉⠀⠀⠀⠀⠀⢄⠀⢀⠀⠀⠀⠀⠉⠉⠁⠀⠀⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿"'
