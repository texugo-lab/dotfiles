source ".zscripts/plugins.zsh"
source ".zscripts/themes.zsh"
source ".zscripts/config.zsh"
source ".zscripts/bindings.zsh"
source ".zscripts/alias.zsh"
source ".zscripts/dependencies.zsh"
source ".zscripts/header.zsh"
source ".zscripts/path.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# DO NOT REMOVE ANY OF THE ABOVE

zPluginUpdate

#  EVALS
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

clear

$HEADER_COMMAND