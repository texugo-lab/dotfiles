dfTheme="Catppuccin-Macchiato"
setTheme() {
    if   [[ "${1}" == "Catppuccin-Mocha"     ]]; then export ZSHFLAVOR="cpMocha"
    elif [[ "${1}" == "Catppuccin-Macchiato" ]]; then export ZSHFLAVOR="cpMacchiato"
    elif [[ "${1}" == "Catppuccin-Frappe"    ]]; then export ZSHFLAVOR="cpFrappe"
    elif [[ "${1}" == "Catppuccin-Latte"     ]]; then export ZSHFLAVOR="cpLatte"
    elif [[ "${1}" == "Tokyonight-Light"     ]]; then export ZSHFLAVOR="tkLight"
    elif [[ "${1}" == "Tokyonight-Night"     ]]; then export ZSHFLAVOR="tkNight"
    elif [[ "${1}" == "Tokyonight-Storm"     ]]; then export ZSHFLAVOR="tkStorm"
    elif [[ "${1}" == "Dracula"              ]]; then export ZSHFLAVOR="dcDracula"
    elif [[ "${1}" == "--list"               ]]; then
        echo "   Catppuccin-Mocha"
        echo "   Catppuccin-Macchiato -> DEFAULT"
        echo "   Catppuccin-Frappe"
        echo "   Catppuccin-Latte"
        echo "   Tokyonight-Light"
        echo "   Tokyonight-Night"
        echo "   Tokyonight-Storm"
        echo "   Dracula"
        return 0
    else
        echo "Theme not found; Changing Theme to default ($dfTheme)"
        setTheme "$dfTheme"
        return 0
    fi
    echo "Changing Theme to ${1}
    "
    reloadTheme
}
reloadTheme() {
    if   [[ "$ZSHFLAVOR" == "cpMocha"     ]] ||
         [[ "$ZSHFLAVOR" == "cpMacchiato" ]] ||
         [[ "$ZSHFLAVOR" == "cpFrappe"    ]] ||
         [[ "$ZSHFLAVOR" == "cpLatte"     ]] ||
         [[ "$ZSHFLAVOR" == "dcDracula"   ]] ||
         [[ "$ZSHFLAVOR" == "tnLight"     ]] ||
         [[ "$ZSHFLAVOR" == "tnNight"     ]] ||
         [[ "$ZSHFLAVOR" == "tnStorm"     ]]; then source "themes/$ZSHFLAVOR/load.zsh"
    fi
}