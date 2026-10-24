THEME_LOCATION="$(dirname $0)/"
export LS_COLORS="$(vivid generate nord)"
export BAT_THEME="Nord"
cp "${THEME_LOCATION}/config.conf" "$HOME/.config/neofetch/"
cp "${THEME_LOCATION}/../header.txt" "$HOME/.config/neofetch/"
source "${THEME_LOCATION}fzf.zsh"
source "${THEME_LOCATION}zsh-sh.zsh"

toml set ~/.config/starship/conf.toml palettes.theme.blue '#5e81ac' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.yellow '#ebcb8b' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.green '#a3be8c' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.black '#3b4252' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.red '#bf616a' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.pink '#b48ead' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.gray '#4c566a' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
