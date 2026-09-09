tmux-menu() {
    local options="Sessions
    Create Session...
    Switch Session...";
    case $(echo $options | fzf-tmux -p -w 75% -h 75%) in
        "    Create Session...")
            tmux display-popup \
                -w 75% \
                -h 75% \
                -E 'bash -c "read -p \"Session name: \" name; echo \$name; tmux new -d -s \$name; tmux switchc -t \$name"'
            ;;
        "    Switch Session...")
            tmux display-popup \
                -w 75% \
                -h 75% \
                -E "tmux list-sessions | sed -E 's/:.*$//' | grep -v \"^$(tmux display-message -p '#S')\$\" | fzf --reverse | xargs tmux switchc -t"
            ;;
    esac
}