THEME_LOCATION="$(dirname $0)/"
export LS_COLORS="$(vivid generate tokyonight-day)"
cp "${THEME_LOCATION}/config.conf" "$HOME/.config/neofetch/"
cp "${THEME_LOCATION}/../header.txt" "$HOME/.config/neofetch/"
source "${THEME_LOCATION}fzf.zsh"
source "${THEME_LOCATION}zsh-sh.zsh"

toml set ~/.config/starship/conf.toml palettes.theme.blue '#2959aa' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.yellow '#8f5e15' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.green '#385f0d' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.black '#6c6e75' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.red '#8c4351' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.pink '#6c6e75' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.gray '#40434f' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
