theme() {
    local dfTheme="Catppuccin-Macchiato"
    if [[ "${1}" == "-h" ]] ||
       [[ "${1}" == "--help" ]]; then
        echo "Usage:"
        echo "  theme -h -> show this help page"
        echo "  theme --help -> show this help page"
        echo
        echo "  theme set <THEME> <FLAGS"
        echo "  theme reload <FLAGS>"
        echo "FLAGS:"
        echo "  -q -> be more quiet"
        echo "THEMES:"
        echo "  Catppuccin-Mocha"
        echo "  Catppuccin-Macchiato -> DEFAULT"
        echo "  Catppuccin-Frappe"
        echo "  Catppuccin-Latte"
        echo "  Tokyonight-Light"
        echo "  Tokyonight-Night"
        echo "  Tokyonight-Storm"
        echo "  Dracula"
	    echo "  Nord"
    elif [[ "${1}" == "set" ]]; then
        if   [[ "${2}" == "Catppuccin-Mocha"     ]]; then export ZTHEME="cpMocha"
        elif [[ "${2}" == "Catppuccin-Macchiato" ]]; then export ZTHEME="cpMacchiato"
        elif [[ "${2}" == "Catppuccin-Frappe"    ]]; then export ZTHEME="cpFrappe"
        elif [[ "${2}" == "Catppuccin-Latte"     ]]; then export ZTHEME="cpLatte"
        elif [[ "${2}" == "Tokyonight-Light"     ]]; then export ZTHEME="tkLight"
        elif [[ "${2}" == "Tokyonight-Night"     ]]; then export ZTHEME="tkNight"
        elif [[ "${2}" == "Tokyonight-Storm"     ]]; then export ZTHEME="tkStorm"
        elif [[ "${2}" == "Dracula"              ]]; then export ZTHEME="dcDracula"
        elif [[ "${2}" == "Nord"                 ]]; then export ZTHEME="ndNight"
        else
            echo "Theme not found; Changing Theme to default ($dfTheme)"
            theme set "$dfTheme" -q
            return 0
        fi
        if [[ "${3}" != "-q" ]]; then
            echo "Changing Theme to ${2}
            "
        fi
        theme reload
    elif [[ "${1}" == "reload" ]]; then
        zAddFile "$HOME/.zthemes/$ZTHEME/load.zsh"
    else
        echo "Use 'theme --help' or 'theme -h' to see the full help page"
    fi
}
