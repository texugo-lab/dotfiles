ZPLUGINDIR='$HOME/.config/zshplugins'
zsPluginLoad() {
    plugin_path="${ZPLUGINDIR}/${2}"
    if [[ ! -d "$plugin_path" ]]; then
        mkdir -p "$ZPLUGINDIR"
        git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
          || echo { echo "${2} failed to install" >&2; return 1; }
        source "$plugin_path/${2}.plugin.zsh"
    fi
}
zPluginUpdate() {
    local dir
    for dir in "${ZPLUGINDIR}"/*/; do
        echo "Updating ${dir:t}..."
        git -C "$dir" pull -ff-only
    done
}

#  GUIDE:
#     zPluginLoad <GIT_USER_NAME> <REPOSITORY_NAME>
#     zPluginLoad zsh-users       zsh-syntax-highlighting
zPluginLoad zsh-users      zsh-autosuggestions
zPluginLoad zsh-users      zsh-completions; autoload -U compinit && compinit
zPluginLoad zsh-users      zsh-history-substring-search
zPluginLoad Aloxaf         fzf-tab
zPluginLoad MichalAquilina zsh-auto-notify
zPluginLoad zsh-users      zsh-syntax-highlighting