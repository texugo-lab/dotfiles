alias ls="ls --color"
alias la="ls -a"
autoload zmv
alias mv='zmv'
alias src='source $HOME/.zshrc'
alias bat="bat -p -n --paging=never --color=always"
alias -g fuzzy='$(fzf --preview="bat -p --color=always {}")'
alias -s md='glow'
