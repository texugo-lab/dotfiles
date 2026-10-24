THEME_LOCATION="$(dirname $0)/"
export LS_COLORS="$(vivid generate catppuccin-macchiato)"
export BAT_THEME="Catppuccin Macchiato"
cp "${THEME_LOCATION}/config.conf" "$HOME/.config/neofetch/"
cp "${THEME_LOCATION}/../header.txt" "$HOME/.config/neofetch/"
source "${THEME_LOCATION}fzf.zsh"
source "${THEME_LOCATION}zsh-sh.zsh"

toml set ~/.config/starship/conf.toml palettes.theme.blue '#8aadf4' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.yellow '#eed49f' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.green '#a6da95' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.black '#363a4f' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.red '#ed8796' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.pink '#c6a0f6' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.gray '#5b6078' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
