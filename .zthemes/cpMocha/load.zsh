THEME_LOCATION="$(dirname $0)/"
export LS_COLORS="$(vivid generate catppuccin-mocha)"
export BAT_THEME="Catppuccin Mocha"
cp "${THEME_LOCATION}/config.conf" "$HOME/.config/neofetch/"
cp "${THEME_LOCATION}/../header.txt" "$HOME/.config/neofetch/"
source "${THEME_LOCATION}fzf.zsh"

toml set ~/.config/starship/conf.toml palettes.theme.blue '#89b4fa' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.yellow '#f9e2af' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.green '#a6e3a1' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.black '#313244' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.red '#f38ba8' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.pink '#cba6f7' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.gray '#585b70' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
