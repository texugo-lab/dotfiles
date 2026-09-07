alias ls="ls --color --group-directories-first"
alias la="ls -A"
alias lh="la -lh"
alias lv="la -1"
autoload zmv
alias src='source $HOME/.zshrc'
alias batp="bat -p -n --paging=never --color=always"
alias fzfp='fzf --preview="bat -p --color=always {}" --preview-border="sharp" --preview-window=right:75%'
alias tm="tmuxifier"
alias hstReset="rm -rf $HISTFILE && touch $HISTFILE"
