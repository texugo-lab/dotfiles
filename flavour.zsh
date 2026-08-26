setFlavor() {
    if [[ "${1}" == "Mocha" ]]; then
        export FLAVOR="mocha"
    elif [[ "${1}" == "Macchiato" ]]; then
        export FLAVOR="macchiato"
    elif [[ "${1}" == "Frappe" ]]; then
        export FLAVOR="frappe"
    elif [[ "${1}" == "Latte" ]]; then
        export FLAVOR="latte"
    else
        echo "Flavor not found"
        return 1;
    fi
    echo "Changing Flavor to ${1}"
    reloadFlavor
}
reloadFlavor() {
    if [ "$FLAVOR" == "mocha" ]; then
       # MOCHA
       source "catppuccin/mocha/*.sh"
       source "catppuccin/mocha/*.zsh"
    elif [ "$FLAVOR" == "frappe" ]; then
       # FRAPPE
       source "catppuccin/frappe/*.sh"
       source "catppuccin/frappe/*.zsh"
    elif [ "$FLAVOR" == "latte" ]; then
       # LATTE
       source "catppuccin/latte/*.sh"
       source "catppuccin/latte/*.zsh"
    else
       # MACCHIATO
       source "catppuccin/macchiato/*.sh"
       source "catppuccin/macchiato/*.zsh"
    fi
}