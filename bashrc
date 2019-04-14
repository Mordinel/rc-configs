[[ $- != *i* ]] && return

color="31"

if [ "$USER" == "root" ];
then
    color="32"
fi

export PS1="\[\e[0;"$color"m\]\u\[\e[1;37m\]@\[\e[0;"$color"m\]\h\[\e[1;37m\]:[\[\e[1;"$color"m\]\w\[\e[1;37m\]]:\[\e[0m\]"
export EDITOR="vim"

alias ls='ls --color=auto'
