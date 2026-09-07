session_root "$HOME"
if initialize_session "main"; then
  new_window "Window"
  new_window "Window"
  select_window 1
  run_cmd "$EDITOR"
  select_window 2
fi

finalize_and_go_to_session
