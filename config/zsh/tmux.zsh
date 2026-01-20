# ----- Tmux layout functions -----
function ide() {
  tmux split-window -h
  tmux select-pane -t 4 
  tmux resize-pane -R 40
  tmux send-keys "opencode" C-m
  tmux select-pane -t 1
  tmux split-window -v
  tmux split-window -h
  tmux resize-pane -D 10
  tmux select-pane -t 3
  tmux resize-pane -L 20
  tmux send-keys "lazygit" C-m
  tmux select-pane -t 1
  tmux send-keys "vi" C-m
}

function vault() {
  tmux split-window -h
  tmux split-window -v
  tmux resize-pane -R 40
  tmux select-pane -t 1
  tmux send-keys "vi" C-m
}

function split() {
  tmux split-window -v
  tmux split-window -h
  tmux select-pane -t 1 
  tmux split-window -h
  tmux select-pane -t 1 
}
