# Get current host IP
export HOST_IP=$(ipconfig.exe | grep "Endereço IPv4" | awk '{print $NF}' | head -n 1)

# Configure PulseAudio Server
export PULSE_SERVER=tcp:$HOST_IP

source "$HOME/.zscripts/file.zsh"
zAddFile "$HOME/.zscripts/path.zsh"
zAddFile "$HOME/.zscripts/functions.zsh"

zAddFile "$HOME/.fzf.zsh"

zAddFile "$HOME/.zscripts/plugins.zsh"
zPlugin loadAll
zAddFile "$HOME/.zscripts/themes.zsh"
zAddFile "$HOME/.zscripts/bindings.zsh"
zAddFile "$HOME/.zscripts/alias.zsh"
zAddFile "$HOME/.zscripts/dependencies.zsh"
zAddFile "$HOME/.zscripts/header.zsh"
zAddFile "$HOME/.zscripts/config.zsh"

eval "$(zoxide init zsh)"
eval "$(tmuxifier init -)"

$HEADER_COMMAND
