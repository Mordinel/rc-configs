[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ];
then
    . ~/.bash_aliases;
fi

color="32"

if [ $(id -u) -eq 0 ];
then
    color="31"
fi

export PS1="\[\e[0;"$color"m\]\u\[\e[1;37m\]@\[\e[0;"$color"m\]\h\[\e[1;37m\]:[\[\e[1;"$color"m\]\W\[\e[1;37m\]]:\[\e[0m\]"
export EDITOR="vim"

alias ls='ls --color=auto'
alias open='2>/dev/null xdg-open'
