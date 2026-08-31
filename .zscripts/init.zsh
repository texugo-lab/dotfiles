source "$HOME/.zscripts/plugins.zsh"
source "$HOME/.zscripts/themes.zsh"
source "$HOME/.zscripts/config.zsh"
source "$HOME/.zscripts/bindings.zsh"
source "$HOME/.zscripts/alias.zsh"
source "$HOME/.zscripts/dependencies.zsh"
source "$HOME/.zscripts/header.zsh"
source "$HOME/.zscripts/path.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# DO NOT REMOVE ANY OF THE ABOVE

zPluginUpdate

#  EVALS
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

clear

$HEADER_COMMAND
