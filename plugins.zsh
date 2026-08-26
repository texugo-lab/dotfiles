ZPLUGINDIR='$HOME/.config/zshplugins'
zpluginload() {
    plugin_path="${ZPLUGINDIR}/${2}"
    if [[ ! -d "$plugin_path" ]]; then
        mkdir -p "$ZPLUGINDIR"
        git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path/${2}" \
          || echo { echo "${2} failed to install" >&2; return 1; }
        source "$plugin_path/${2}/${2}.plugin.zsh"
    fi
}