if initialize_session "fltc"; then
	tmux new-window "env /mnt/c/pulse/bin/pulseaudio.exe"
	tmux split -v "mpd --kill; mpd; rmpc"
	tmux resizep -Z
	tmux new-window -b
fi

finalize_and_go_to_session
