# Catppuccin Mocha Theme (for zsh-syntax-highlighting)
#
# Paste this files contents inside your ~/.zshrc before you activate zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES

# Main highlighter styling: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
#
## General
### Diffs
### Markup
## Classes
## Comments
ZSH_HIGHLIGHT_STYLES[comment]='fg=#343B58'
## Constants
## Entitites
## Functions/methods
ZSH_HIGHLIGHT_STYLES[alias]='fg=#385f0d'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#385f0d'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#385f0d'
ZSH_HIGHLIGHT_STYLES[function]='fg=#385f0d'
ZSH_HIGHLIGHT_STYLES[command]='fg=#385f0d'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#385f0d,italic'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#965027,italic'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#965027'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#965027'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#5a3e8e'
## Keywords
## Built ins
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#385f0d'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#385f0d'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#385f0d'
## Punctuation
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#8c4351'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#40434f'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#40434f'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#40434f'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#8c4351'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#8c4351'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#8c4351'
## Serializable / Configuration Languages
## Storage
## Strings
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#8f5e15'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#8f5e15'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#8f5e15'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#8c4351'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#8f5e15'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#8c4351'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#8f5e15'
## Variables
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#40434f'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#8c4351'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#40434f'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#40434f'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#40434f'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#40434f'
## No category relevant in spec
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#8c4351'
ZSH_HIGHLIGHT_STYLES[path]='fg=#40434f,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#8c4351,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#40434f,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#8c4351,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#40434f'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#5a3e8e'
#ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=?'
#ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=?'
#ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=?'
#ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=?'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#8c4351'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#40434f'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#40434f'
ZSH_HIGHLIGHT_STYLES[default]='fg=#40434f'
ZSH_HIGHLIGHT_STYLES[cursor]='fg=#40434f'
