dfFlavor='Catppuccin-Macchiato'
reloadTheme() {
    if [ "$ZSHFLAVOR" == "cpMocha" ] ||
    [ "$ZSHFLAVOR" == "cpMacchiato" ] ||
    [ "$ZSHFLAVOR" == "cpFrappe" ] ||
    [ "$ZSHFLAVOR" == "cpLatte" ] ||
    [ "$ZSHFLAVOR" == "tkLight" ] ||
    [ "$ZSHFLAVOR" == "tkNight" ] ||
    [ "$ZSHFLAVOR" == "tkStorm" ] ||
    [ "$ZSHFLAVOR" == "dcDracula" ]; then
       source "themes/$ZSHFLAVOR/*.sh"
       source "themes/$ZSHFLAVOR/*.zsh"
    else
        echo "Unknown flavor"
        return 1
    fi
}
setTheme() {
    if [[ "${1}" == "Catppuccin-Mocha" ]]; then
        export ZSHFLAVOR="cpMocha"
    elif [[ "${1}" == "Catppuccin-Macchiato" ]]; then
        export ZSHFLAVOR="cpMacchiato"
    elif [[ "${1}" == "Catppuccin-Frappe" ]]; then
        export ZSHFLAVOR="cpFrappe"
    elif [[ "${1}" == "Catppuccin-Latte" ]]; then
        export FZSHLAVOR="cpLatte"
    elif [[ "${1}" == "Tokyonight-Light" ]]; then
        export FZSHLAVOR="tkLight"
    elif [[ "${1}" == "Tokyonight-Night" ]]; then
        export FZSHLAVOR="tkNight"
    elif [[ "${1}" == "Tokyonight-Storm" ]]; then
        export FZSHLAVOR="tkStorm"
    elif [[ "${1}" == "Dracula" ]]; then
        export FZSHLAVOR="dcDracula"
    else
        echo "Flavor not found, changing to default (${dfFlavor})"
        setTheme "${dfFlavor}"
    fi
    echo "Changing Flavor to ${1}"
    reloadTheme
}