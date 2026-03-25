# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete)
source $ZSH/oh-my-zsh.sh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval $(crc oc-env)

alias kx="kubectx"
alias kn="kubens"
alias ll="ls -la"
alias gfp="git fetch && git pull"
alias gst="git status"
alias k="kubectl"
alias gch="git checkout"
alias cat="bat"
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# fnm
export PATH="/Users/martin/Library/Application Support/fnm:$PATH"
eval "`fnm env`"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Plugins — defined above source $ZSH/oh-my-zsh.sh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/martin/.lmstudio/bin"
# End of LM Studio CLI section


# Added by Antigravity
export PATH="/Users/martin/.antigravity/antigravity/bin:$PATH"
#export NODE_TLS_REJECT_UNAUTHORIZED=0
export NODE_EXTRA_CA_CERTS="/Users/martin/dev/datera/DATERA_INTERNAL_CA.crt"

# pnpm
export PNPM_HOME="/Users/martin/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
fpath+=(~/.config/hcloud/completion/zsh)
autoload -Uz compinit; compinit
