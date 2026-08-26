#---------------------- SOURCE ----------------------#
source "plugins.zsh" # DO NOT REMOVE
source "flavors.zsh" # DO NOT REMOVE

#---------------------- PLUGIN ----------------------#
#  GUIDE:
#     zpluginload <GIT_USER_NAME> <REPOSITORY_NAME>

zpluginload zsh-users zsh-syntax-highlighting
zpluginload zsh-users zsh-autosuggestions
zpluginload zsh-users zsh-history-substring-search

# AUTOLOAD
autoload zmv

# EVALS
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

#---------------------- CONFIG ----------------------#
setFlavor Macchiato
#  Possible values:
#     Mocha
#     Macchiato -> DEFAULT
#     Frappe
#     Latte
#  To add any more flavor based config, make
#  sure to follow these steps: 
#     1-  add a '.zsh' or '.sh' file to the
#     catppuccin/FLAVOR that you want,
#     preferebly on all

export EDITOR='nvim' # EDITOR

#----------------------- CODE -----------------------#
#  BINDINGS
#     COMMAND-LINE EDIT
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# CHPWD
chpwd() {
   eza
}

#  HISTORY
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#  ALIAS
alias ls='eza'
alias mv='zmv'

reloadFlavor # KEEP THIS AT THE VERY BOTTOM