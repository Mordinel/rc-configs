[[ $- != *i* ]] && return

color="32"

if [ $(id -u) -eq 0 ];
then
    color="31"
fi

export PS1="\[\e[0;"$color"m\]\u\[\e[1;37m\]@\[\e[0;"$color"m\]\h\[\e[1;37m\]:[\[\e[1;"$color"m\]\w\[\e[1;37m\]]:\[\e[0m\]"
export EDITOR="vim"

alias ls='ls --color=auto'
alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -selection clipboard -o'
