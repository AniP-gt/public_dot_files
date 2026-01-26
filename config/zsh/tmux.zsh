# ----- Tmux layout functions -----
# IDE layout
function ide() {
  tmux split-window -v
  tmux split-window -h
  tmux resize-pane -D 12
  tmux select-pane -t 3
  tmux resize-pane -L 25
  tmux split-window -h
  tmux select-pane -t 1
  tmux split-window -h
  tmux select-pane -t 2 
  tmux resize-pane -R 40
  # tmux send-keys "opencode" C-m # use AI agent
  tmux select-pane -t 1
  tmux send-keys "vi" C-m
}

# vault layout
function vault() {
  tmux split-window -h
  tmux split-window -v
  tmux resize-pane -R 40
  tmux select-pane -t 1
  tmux send-keys "vi" C-m
}

# 4-pane layout
function split() {
  tmux split-window -v
  tmux split-window -h
  tmux select-pane -t 1 
  tmux split-window -h
  tmux select-pane -t 1 
}

