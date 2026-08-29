setTheme Catppuccin-Macchiato
#         Catppuccin-Mocha
#         Catppuccin-Macchiato -> DEFAULT
#         Catppuccin-Frappe
#         Catppuccin-Latte
#         Tokyonight-Day
#         Tokyonight-Night
#         Tokyonight-Storm
#         Dracula
#  To add any more flavor based config, make sure to follow these steps:
#     1-  add a '.zsh' or '.sh' file to the catppuccin/FLAVOR that you want, preferebly on all
#     2-  add that file to load.zsh

export EDITOR='nvim' # EDITOR
export VISUAL='nvim' # VISUAL

#  HISTORY
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# TAB COMPLETION
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls $realpath"
zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview "ls $realpath"

chpwd() {
   la
}