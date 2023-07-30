# If not running interactively, don't do anything
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -l'

alias a=ag
alias aa='ag --nonumbers --nofilename'
T='--ignore-dir=__tests__ --ignore-dir=__legacy__'
alias agt='ag --ignore-dir __tests__'
alias aat='ag --nonumbers --nofilename --ignore-dir __tests__'
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
alias add='grep -v ^$|paste -s -d+|bc'
alias m='PAGER=most man'
alias fin='tail -n1'
alias hed='head -n1'
alias pf='pgrep -fal'
yqmerge() {
  yq ea '. as $i ireduce ({}; . * $i)' $@
}

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
alias ..='cd ..'
alias wget='wget -c' #resume last download
ports() {
  # sudo netstat -tulanp | grep ${1:-''}
  sudo ss -HlnpO src :$1 | awk '{print $NF}'|tr , '\t'|tr = ' '
}

alias pe=perl
alias py=python3
alias p=python3
alias n=node
alias rslv='getent hosts'

# ubuntu
alias sus='systemctl suspend'
alias apd='sudo apt update'
alias apg='sudo apt upgrade'
alias api='sudo apt install'
alias apr='sudo apt remove'
alias apu='sudo apt autoremove'
aps() {
  apt show $@ 2>/dev/null|perl -ne '/Description/ .. /^$/ and print'
}

#grep for files
gf() {
  find ${2:-.} -ipath "*$1*"
}
inplace() {
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

[ -f ~/.cribl.bashrc ] && . ~/.cribl.bashrc

if [ $UID -eq 0 ]; then
   export PS1='\w# '
   ps1=$PS1
fi
if [ -n "$DISPLAY" ]; then
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
# din() {
#     docker exec -it $1 ${2:-/bin/bash}
# }
# did() {
#     docker ps -a | ag ${1:-' '} | cut -f1 -d' '
# }

alias encrypt='openssl enc -aes-256-cbc -salt -in'
alias decrypt='openssl enc -d -aes-256-cbc -salt -in'

# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
export PYTHONSTARTUP=~/.pystartup

# Run 'fff' with 'f' or whatever you decide to name the function.
f() {
  fff "$@"
  cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

alias vs='v $(g status -suno --porcelain|awk "{print \$2}")'

vd() {
  v `git diff ${1:-origin/dev}... --name-only --diff-filter=RAM`
}
va() {
  v `ag -wl "'$@'"`
}
vag() {
  v `ag -l "'$@'"`
}
vsh() {
  v `git sh --name-only --pretty= "'$@'"`
}

export PATH=$PATH:~/bin:~/dev/ticket/scripts

[ -e .dircolors ] && eval `dircolors .dircolors`
alias fd=fdfind
alias c=cd
alias r='rm -r'

blamer() {
  grep $@ -R --line-number 2>/dev/null|cut -d: -f1,2|tr ':' ' ' \
    |while read f l; do
      git blame $f -L$l,$l --porcelain 2>/dev/null|sed -n 's/^author //p';
    done|sort|uniq -c|sort -rn
}

alias napi='napi.sh scan -Cutf-8 -L PL'
pogoda() {
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

tmp() {
  dir=`mktemp -d /tmp/${1}_XXXX`
  echo $dir
  cd $dir
}

alias ff='xdg-settings set default-web-browser firefox.desktop'
alias bb='xdg-settings set default-web-browser brave-browser.desktop'

alias drm='d rm -f `d ps -qa`; d volume prune -f; d network prune -f'
alias todo="jql 'assignee=currentUser() and resolution is empty and status in (open,\"to do\")'"
mine() {
  jql 'assignee=currentUser()' $@ |tac
}
reported() {
  jql 'reporter=currentUser()' $@ |tac
}
prog="status='in progress'"
