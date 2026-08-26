dfFlavor='macchiato'
setFlavor() {
    if [[ "${1}" == "Mocha" ]]; then
        export ZSHFLAVOR="mocha"
    elif [[ "${1}" == "Macchiato" ]]; then
        export ZSHFLAVOR="macchiato"
    elif [[ "${1}" == "Frappe" ]]; then
        export ZSHFLAVOR="frappe"
    elif [[ "${1}" == "Latte" ]]; then
        export FZSHLAVOR="latte"
    else
        echo "Flavor not found, changing to default (Macchiato)"
        export ZSHFLAVOR="$dfFlavor"
        return 1
    fi
    echo "Changing Flavor to ${1}"
    reloadFlavor
}
reloadFlavor() {
    if [ "$ZSHFLAVOR" == "mocha" ]; then
       # MOCHA
       source "catppuccin/mocha/*.sh"
       source "catppuccin/mocha/*.zsh"
    elif [ "$ZSHFLAVOR" == "macchiato" ]; then
       # MACCHIATO
       source "catppuccin/macchiato/*.sh"
       source "catppuccin/macchiato/*.zsh"
    elif [ "$ZSHFLAVOR" == "frappe" ]; then
       # FRAPPE
       source "catppuccin/frappe/*.sh"
       source "catppuccin/frappe/*.zsh"
    elif [ "$ZSHFLAVOR" == "latte" ]; then
       # LATTE
       source "catppuccin/latte/*.sh"
       source "catppuccin/latte/*.zsh"
    else
        echo "Unknown flavor"
        return 1
    fi
}