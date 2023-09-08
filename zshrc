
if [ $(id -u) -eq 0 ];
then
    PS1="%F{red}%m%f%F{fg}:[%f%B%F{red}%1~%f%b%F{fg}]:%f"
else
    PS1="%F{red}%n%f%F{fg}@%f%F{red}%m%f%F{fg}:[%f%B%F{red}%1~%f%b%F{fg}]:%f"
fi

export EDITOR="vim"
alias vim='nvim'
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

