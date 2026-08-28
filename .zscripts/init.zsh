# CHANGE SHELL INCASE NEEDED
if [ "$SHELL" -ne "$(which zsh)" ]; then
    sudo chsh -s "$(which zsh)"
fi
source "plugins.zsh"
source "flavors.zsh"
source "config.zsh"
source "bindings.zsh"
source "alias.zsh"
source "dependencies.zsh"
# DO NOT REMOVE ANY OF THE ABOVE

zPluginUpdate

#  EVALS
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

clear

reloadFlavor # KEEP THIS AT THE VERY BOTTOM