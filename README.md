# tmux-config

## Installation
```
curl -sSL https://github.com/codisms/tmux-config/raw/master/install.sh | bash -s -- \
  [--build] [--version=<version>]
```

## Notable Options
* Uses solarized coloring
* vi copy mode
* resurrect and continuum plugins

## Key Mappings
* Prefix remapped to Ctrl-a
* Most default key mappings disabled
* P-r = reload config
* vi mappings (P-j, P-k, P-l, P-h) for switching panes
* P-Shift-Left/Right = swap windows left/right
* P-| = split horizontal
* P-- = split vertical
* P-Up/Down/Left/Right = resize pane up/down/left/right by 5
* P-Meta-Up/Down/Left/Right = resize pane up/down/left/right by 1
* P-Ctrl-Up/Down/Left/Right = resize pane up/down/left/right by 10
