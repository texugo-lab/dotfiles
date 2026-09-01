export ZPLUGINDIR="$HOME/.config/zshplugins"
zPluginLoad() {
    plugin_path="${ZPLUGINDIR}/${2}"
    if [ ! -d "$plugin_path" ]; then
        mkdir -p "$ZPLUGINDIR"
        git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path"
        local dir
        for dir in "$plugin_path"/*.zsh; do
            echo "${dir:t}"
        done
        zAddFile "$plugin_path/${2}"
        zAddFile "$plugin_path/${2}.plugin.zsh"
        zAddFile "$plugin_path/${2}.zsh"
    fi
}
zPluginUpdate() {
    local dir
    for dir in "${ZPLUGINDIR}"/*/; do
        echo "Updating ${dir:t}..."
        git -C "$dir" pull --ff-only
        zAddFile "${ZPLUGINDIR}/${dir:t}/${dir:t}"
        zAddFile "${ZPLUGINDIR}/${dir:t}/${dir:t}.plugin.zsh"
        zAddFile "${ZPLUGINDIR}/${dir:t}/${dir:t}.zsh"
    done
}

#  GUIDE:
#     zPluginLoad <GIT_USER_NAME> <REPOSITORY_NAME>
#     zPluginLoad zsh-users       zsh-syntax-highlighting
zPluginLoad zsh-users       zsh-autosuggestions
zPluginLoad zsh-users       zsh-completions; autoload -U compinit && compinit
zPluginLoad zsh-users       zsh-history-substring-search
zPluginLoad Aloxaf          fzf-tab
zPluginLoad zsh-users       zsh-syntax-highlighting
zPluginLoad jeffreytse      zsh-vi-mode
