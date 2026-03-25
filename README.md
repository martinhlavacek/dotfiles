# dotfiles

Personal macOS dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

```bash
git clone git@github.com:martinhlavacek/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

The bootstrap script will:
1. Install Homebrew (if not present)
2. Install all packages from `Brewfile`
3. Install GNU Stow
4. Symlink all config packages to `$HOME`
5. Install Oh My Zsh + plugins
6. Install Tmux Plugin Manager (tpm)
7. Install Fish plugins via fisher

## Structure

Each top-level directory is a **stow package** that mirrors the home directory structure:

```
dotfiles/
├── bootstrap.sh          # Full setup script
├── Brewfile              # Homebrew packages, casks, vscode extensions
├── zsh/
│   ├── .zshrc
│   └── .zprofile
├── git/
│   ├── .gitconfig
│   └── .config/git/
│       ├── allowed_signers
│       └── ignore
├── alacritty/
│   └── .config/alacritty/alacritty.yml
├── btop/
│   └── .config/btop/btop.conf
├── fish/
│   └── .config/fish/
│       ├── config.fish
│       ├── fish_plugins
│       ├── conf.d/
│       ├── completions/
│       └── functions/
├── gh/
│   └── .config/gh/config.yml
├── nvim/
│   └── .config/nvim/
├── lvim/
│   └── .config/lvim/
├── skhd/
│   └── .config/skhd/skhdrc
├── starship/
│   └── .config/starship.toml
├── tmux/
│   └── .config/tmux/
│       ├── tmux.conf
│       ├── gitmux.conf
│       └── plugins/tpm/
└── yabai/
    └── .config/yabai/yabairc
```

## How Stow Works

Stow creates symlinks from the package directory into the target (`$HOME`).
For example, running `stow zsh` creates:

```
~/.zshrc → ~/dotfiles/zsh/.zshrc
```

The repo can live anywhere on disk. The bootstrap script detects its own location:

```bash
# Link everything
./bootstrap.sh

# Or link individual packages manually
stow -d /path/to/dotfiles -t ~ zsh git tmux
```

### Common Stow Commands

```bash
# Link a package
stow -t ~ <package>

# Unlink a package
stow -t ~ -D <package>

# Re-link (useful after changes)
stow -t ~ --restow <package>

# Dry run (preview what would happen)
stow -t ~ -n -v <package>
```

## Managing Packages

### Add a new config

```bash
# Example: adding a new tool 'lazygit'
mkdir -p lazygit/.config/lazygit
cp ~/.config/lazygit/config.yml lazygit/.config/lazygit/
stow -t ~ lazygit
# Add 'lazygit' to PACKAGES array in bootstrap.sh
```

### Update Brewfile

```bash
brew bundle dump --file=Brewfile --force
```

## Post-Setup

After running `bootstrap.sh`, you may need to:

- **Git**: Update `~/.gitconfig` with your user name, email, and signing key path
- **Tmux**: Open tmux and press `prefix + I` to install plugins
- **Neovim**: Open `nvim` and wait for lazy.nvim to install plugins
- **GitHub CLI**: Run `gh auth login`
- **Fish**: Plugins should auto-install; if not, run `fisher update`

## Shells

- **Primary**: Zsh with Oh My Zsh + Powerlevel10k + Starship
- **Secondary**: Fish (configured but not default)

### Zsh Plugins
- zsh-autosuggestions
- zsh-syntax-highlighting
- zsh-autocomplete

### Tmux Plugins (via tpm)
- t-smart-tmux-session-manager
- tmux-fzf-url
- tmux-nerd-font-window-name
- vim-tmux-navigator

## Window Management

- **yabai** - Tiling window manager
- **skhd** - Hotkey daemon (keybindings for yabai)
