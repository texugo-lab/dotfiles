command which fzf >/dev/null 2>&1 && {} || { echo "FZF NOT INSTALLED, INSTALLING"; git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; ~/.fzf/install; }
command which bat >/dev/null 2>&1 && {} || { echo "BAT NOT INSTALLED, INSTALLING"; wget https://github.com/sharkdp/bat/releases/download/v0.26.1/bat_0.26.1_amd64.deb -q; sudo dpkg -i bat_0.26.1_amd64.deb; rm -rf bat_0.26.1_amd64.deb; }
command which zoxide >/dev/null 2>&1 && {} || { echo "ZOXIDE NOT INSTALLED, INSTALLING"; sudo apt install zoxide; }
command which starship >/dev/null 2>&1 && {} || { echo "STARSHIP NOT INSTALLED, INSTALLING"; curl -sS https://starship.rs/install.sh | sh; }
command which neofetch >/dev/null 2>&1 && {} || { echo "NEOFETCH NOT INSTALLED, INSTALLING"; sudo apt install neofetch; }
