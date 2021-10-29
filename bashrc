[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ];
then
    . ~/.bash_aliases;
fi

# default to yellow
color="33"

# if root then red
if [ $(id -u) -eq 0 ];
then
    color="31"
fi

# if primary user then green
if [ $(id -u) -eq 1000 ];
then
    color="32"
fi

# if username is sg then green
if [ $(whoami) = "sg" ];
then
    color="32"
fi

export PS1="\[\e[0;"$color"m\]\u\[\e[1;37m\]@\[\e[0;"$color"m\]\h\[\e[1;37m\]:[\[\e[1;"$color"m\]\W\[\e[1;37m\]]:\[\e[0m\]"
export EDITOR="vim"
export TERM=xterm-256color
#export PAGER="vimpager"
export SYSTEMD_PAGER=""

alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
#alias open='2>/dev/null xdg-open'
