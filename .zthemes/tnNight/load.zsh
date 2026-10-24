THEME_LOCATION="$(dirname $0)/"
export LS_COLORS="$(vivid generate tokyonight-night)"
cp "${THEME_LOCATION}/config.conf" "$HOME/.config/neofetch/"
cp "${THEME_LOCATION}/../header.txt" "$HOME/.config/neofetch/"
source "${THEME_LOCATION}fzf.zsh"
source "${THEME_LOCATION}zsh-sh.zsh"

toml set ~/.config/starship/conf.toml palettes.theme.blue '#7aa2f7' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.yellow '#e0af68' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.green '#9ece6a' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.black '#565f89' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.red '#f7768e' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.pink '#bb9af7' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
toml set ~/.config/starship/conf.toml palettes.theme.gray '#414868' > ~/.config/starship.toml
cat ~/.config/starship.toml > ~/.config/starship/conf.toml
