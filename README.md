# dotfiles

## tmux

### Start iTerm2 with tmux session

> Open iTerm2's preferences, then select the 'Profiles' tab, and finally the 'General' pane. In the 'Command' section locate the 'Send text at start:' option and put in this command, substituting your session name for base.

```
tmux attach -t base || tmux new -s base
```

> Now anytime you start iTerm2 (or create a new window) tmux will first try to attach to a session called base, or, if that session doesn't exist, it will create a new session called base.

### Start tmux wih gnome-terminal

```
gnome-terminal -e tmux
```
