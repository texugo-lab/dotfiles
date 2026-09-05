export ZPLUGINDIR="$HOME/.config/zshplugins"
zPlugin() {
    if [[ "${1}" == "-h" ]] ||
       [[ "${1}" == "--help" ]]; then
        echo "Usage:"
        echo "  zPlugin -h -> show this help page"
        echo "  zPlugin --help -> show this help page"
        echo
        echo "  zPlugin load <GITHUB_REPOSITORY>"
        echo "  zPlugin loadAll"
        echo "  zPlugin update <FLAGS>"
        echo "FLAGS:"
        echo "  -q -> be more quiet"
    elif [[ "${1}" == "reset" ]]; then
        local dir
        for dir in "${ZPLUGINDIR}"/*/; do
            echo "Deleting ${dir:t}"
            rm -rf "$dir"
        done
    elif [[ "${1}" == "load" ]]; then
        local repo="${2##*https://github.com/}"
        repo="${repo##*/}"
        plugin_path="${ZPLUGINDIR}/${repo}"
        if [ ! -d "$plugin_path" ]; then
            mkdir -p "$ZPLUGINDIR"
            echo "Installing ${repo}"
            git clone --depth=1 "${2}" "$plugin_path" -q
        fi
        zAddFile "$plugin_path/${repo}"
        zAddFile "$plugin_path/${repo}.plugin.zsh"
        zAddFile "$plugin_path/${repo}.zsh"
        zAddFile "$plugin_path/${repo##*zsh-}.plugin.zsh"
        zAddFile "$plugin_path/${repo##*zsh-}.zsh"
    elif [[ "${1}" == "loadAll" ]]; then
        local dir
        for dir in "${ZPLUGINDIR}"/*/; do
            zAddFile "${ZPLUGINDIR}/${dir:t}/${dir:t}"
            zAddFile "${ZPLUGINDIR}/${dir:t}/${dir:t}.zsh"
            zAddFile "${ZPLUGINDIR}/${dir:t}/${dir:t}.plugin.zsh"
            zAddFile "${ZPLUGINDIR}/${dir:t}/${${dir:t}##*zsh-}"
            zAddFile "${ZPLUGINDIR}/${dir:t}/${${dir:t}##*zsh-}.zsh"
            zAddFile "${ZPLUGINDIR}/${dir:t}/${${dir:t}##*zsh-}.plugin.zsh"
        done
    elif [[ "${1}" == "update" ]]; then
        local dir
        for dir in "${ZPLUGINDIR}"/*/; do
            if [[ "${2}" == "-q" ]]; then
                git -C "$dir" pull --depth=1 --ff-only -q
            else
                echo "updating ${dir:t}"
                git -C "$dir" pull --depth=1 --ff-only
            fi
            zAddFile "${ZPLUGINDIR}/${dir:t}/${dir:t}"
            zAddFile "${ZPLUGINDIR}/${dir:t}/${dir:t}.zsh"
            zAddFile "${ZPLUGINDIR}/${dir:t}/${dir:t}.plugin.zsh"
            zAddFile "${ZPLUGINDIR}/${dir:t}/${${dir:t}##*zsh-}"
            zAddFile "${ZPLUGINDIR}/${dir:t}/${${dir:t}##*zsh-}.zsh"
            zAddFile "${ZPLUGINDIR}/${dir:t}/${${dir:t}##*zsh-}.plugin.zsh"
        done
    else
        echo "Use 'zPlugin --help' or 'zPlugin -h' to see the full help page"
    fi
}

#  GUIDE:
#     zPlugin load <REPOSITORY>
zPlugin load https://github.com/zsh-users/zsh-autosuggestions
zPlugin load https://github.com/zsh-users/zsh-completions; autoload -U compinit && compinit
zPlugin load https://github.com/zsh-users/zsh-history-substring-search
zPlugin load https://github.com/Aloxaf/fzf-tab
zPlugin load https://github.com/zsh-users/zsh-syntax-highlighting
zPlugin load https://github.com/jeffreytse/zsh-vi-mode
zPlugin load https://github.com/akash329d/zsh-alias-finder