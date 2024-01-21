[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ];
then
    . ~/.bash_aliases;
fi

if [ $(id -u) -eq 0 ];
then
    export PS1="[\u@\h \w]# "
else
    export PS1="[\u@\h \w]\$ "
fi

export PATH="~/.scripts:$PATH"
export PATH="~/.local/bin:$PATH"
export PATH="~/.cargo/bin:$PATH"

export EDITOR="vim"
export PAGER="less"
export TERM=xterm-256color
export SYSTEMD_PAGER=""

alias vim='nvim'
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ip='ip --color=auto'
