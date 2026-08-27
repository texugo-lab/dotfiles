source "plugins.zsh"  # DO NOT REMOVE
source "flavors.zsh"  # DO NOT REMOVE
source "config.zsh"   # DO NOT REMOVE
source "bindings.zsh" # DO NOT REMOVE
source "alias.zsh"    # DO NOT REMOVE

zPluginUpdate

#  AUTOLOAD

#  EVALS
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

clear

reloadFlavor # KEEP THIS AT THE VERY BOTTOM