[[ $- != *i* ]] && return

export PS1="\[\e[0;31m\]\u\[\e[1;37m\]@\[\e[0;31m\]\h\[\e[1;37m\]:[\[\e[1;31m\]\w\[\e[1;37m\]]:\[\e[0m\]"

alias ls='ls --color=auto'
