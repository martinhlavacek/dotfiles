#!/usr/bin/env bash
set -euo pipefail

# Detect repo directory (works from any location)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Dotfiles directory: $DOTFILES_DIR"

# ─── Homebrew ────────────────────────────────────────────────────────────────

if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "==> Homebrew already installed"
fi

# ─── Brew packages ───────────────────────────────────────────────────────────

if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
  echo "==> Installing brew packages..."
  brew bundle --file="$DOTFILES_DIR/Brewfile" --no-lock
else
  echo "==> No Brewfile found, skipping"
fi

# ─── GNU Stow ────────────────────────────────────────────────────────────────

if ! command -v stow &>/dev/null; then
  echo "==> Installing stow..."
  brew install stow
fi

# ─── Stow packages ──────────────────────────────────────────────────────────

PACKAGES=(
  zsh
  git
  alacritty
  btop
  fish
  gh
  nvim
  lvim
  skhd
  starship
  tmux
  yabai
)

echo "==> Linking dotfiles with stow..."
for pkg in "${PACKAGES[@]}"; do
  if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
    echo "    Linking $pkg..."
    stow -d "$DOTFILES_DIR" -t "$HOME" --restow "$pkg" 2>&1 | grep -v "^$" || true
  else
    echo "    Skipping $pkg (not found)"
  fi
done

# ─── Oh My Zsh ──────────────────────────────────────────────────────────────

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "==> Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

declare -A ZSH_PLUGINS=(
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
  ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting"
  ["zsh-autocomplete"]="https://github.com/marlonrichert/zsh-autocomplete"
)

for plugin in "${!ZSH_PLUGINS[@]}"; do
  if [[ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]]; then
    echo "    Installing zsh plugin: $plugin"
    git clone "${ZSH_PLUGINS[$plugin]}" "$ZSH_CUSTOM/plugins/$plugin"
  fi
done

# ─── Tmux Plugin Manager ────────────────────────────────────────────────────

TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [[ ! -d "$TPM_DIR" ]]; then
  echo "==> Installing Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# ─── Fish shell plugins ─────────────────────────────────────────────────────

if command -v fish &>/dev/null; then
  echo "==> Installing fish plugins via fisher..."
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update" 2>/dev/null || echo "    Fisher install skipped (run manually if needed)"
fi

# ─── Summary ─────────────────────────────────────────────────────────────────

echo ""
echo "==> Done! Restart your terminal or run: source ~/.zshrc"
echo ""
echo "Post-setup reminders:"
echo "  - Tmux: press prefix + I to install tmux plugins"
echo "  - Git: update ~/.gitconfig with your name, email, and signing key"
echo "  - gh: run 'gh auth login' to authenticate GitHub CLI"
echo "  - Neovim: open nvim and wait for plugins to install"
