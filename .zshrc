# Get current host IP
export HOST_IP=$(ipconfig.exe | grep "Endereço IPv4" | awk '{print $NF}' | head -n 1)

# Configure PulseAudio Server
export PULSE_SERVER=tcp:$HOST_IP

source "$HOME/.zscripts/file.zsh"
zAddFile "$HOME/.zscripts/alias.zsh"
zAddFile "$HOME/.zscripts/path.zsh"
zAddFile "$HOME/.zscripts/functions.zsh"
zAddFile "$HOME/.zscripts/plugins.zsh"
zAddFile "$HOME/.zscripts/themes.zsh"
zAddFile "$HOME/.zscripts/bindings.zsh"
zAddFile "$HOME/.zscripts/dependencies.zsh"

zPlugin loadAll

zAddFile "$HOME/.zscripts/config.zsh"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
alias yazi="y"

eval "$(zoxide init zsh)"
eval "$(tmuxifier init -)"

zAddFile "$HOME/.zscripts/header.zsh"
$HEADER_COMMAND

source <(fzf --zsh)
