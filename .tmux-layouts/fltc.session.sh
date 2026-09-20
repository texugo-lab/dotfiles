if initialize_session "main"; then
  new_window "Window"
  run_cmd "z fltc"
  new_window "Window"
  run_cmd "z fltc"
  select_window 1
  tmux split-pane -h
  tmux resize-pane -R 40
  run_cmd "z fltc"
  tmux select-pane -L
  run_cmd "$EDITOR"
fi

finalize_and_go_to_session
