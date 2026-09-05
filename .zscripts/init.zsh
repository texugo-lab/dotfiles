source "$HOME/.zscripts/file.zsh"

zAddFile "$HOME/.fzf.zsh"
eval $(fzf --zsh)

zAddFile "$HOME/.zscripts/plugins.zsh"
zPlugin loadAll
zAddFile "$HOME/.zscripts/themes.zsh"
zAddFile "$HOME/.zscripts/config.zsh"
zAddFile "$HOME/.zscripts/bindings.zsh"
zAddFile "$HOME/.zscripts/alias.zsh"
zAddFile "$HOME/.zscripts/dependencies.zsh"
zAddFile "$HOME/.zscripts/header.zsh"
zAddFile "$HOME/.zscripts/path.zsh"
# DO NOT REMOVE ANY OF THE ABOVE

#  EVALS
eval "$(zoxide init zsh)"

$HEADER_COMMAND