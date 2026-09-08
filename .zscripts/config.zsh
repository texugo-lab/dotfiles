theme set Catppuccin-Macchiato -q
#         Catppuccin-Mocha
#         Catppuccin-Macchiato -> DEFAULT
#         Catppuccin-Frappe
#         Catppuccin-Latte
#         Tokyonight-Day
#         Tokyonight-Night
#         Tokyonight-Storm
#         Dracula
#         Nord
#  To add any more flavor based config, make sure to follow these steps:
#     1-  add a '.zsh' or '.sh' file to the catppuccin/FLAVOR that you want, preferebly on all
#     2-  add that file to load.zsh

export EDITOR='nvim' # EDITOR
export VISUAL='nvim' # VISUAL

# TMUXIFIER
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmux-layouts"

export FZF_DEFAULT_OPTS="--preview="bat -p --color=always {}" --style=full:line --border=bold --info=hidden --pointer=> --marker=× --input-border=line --preview-border=inline --border-label-pos=18 --input-label-pos=15 --list-label-pos=16 --header-label-pos=22 --preview-window=up"

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
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color -1 -A $realpath"
zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview "ls --color -1 -A $realpath"
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

chpwd() {
   ls --group-directories-first --color -A -1
}
