if [ $(id -u) -eq 0 ];
then
    PS1="[%n@%m %1~]# "
else
    PS1="[%n@%m %1~]\$ "
fi

bindkey -e
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^U' backward-kill-line
bindkey '^K' kill-line
bindkey '^W' backward-kill-word
bindkey '^Y' yank
bindkey '^R' history-incremental-search-backward
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word
bindkey '\eOH' beginning-of-line
bindkey '\eOF' end-of-line

fpath+=~/.zfunc

export EDITOR="vim"
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export PATH="$HOME/.scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
#export PATH="$HOME/.cargo/bin:$PATH"
#export PATH="$HOME/go/bin:$PATH"
#export PATH="/opt/homebrew/bin:$PATH"

#alias vim='nvim'
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
#alias ip='ip --color=auto'

