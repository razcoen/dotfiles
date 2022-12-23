
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#> Setup oh-my-zsh.

export ZSH="$HOME/.oh-my-zsh"

# Configure oh-my-zsh with theme and plugins.
ZSH_THEME="nicoulaj"
plugins=(git)

source $ZSH/oh-my-zsh.sh

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#> Setup zsh plugins.

# VI Mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Auto Suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Integrate VI Mode with Auto Suggestions:
# The vi mode overrides the arrow keys to search through the history of the auto suggestions.
# Followed these issue: https://superuser.com/questions/1357131/zsh-in-vi-mode-but-using-arrow-keys-to-search-history
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -M vicmd '^[[A' history-beginning-search-backward-end \
                 '^[OA' history-beginning-search-backward-end \
                 '^[[B' history-beginning-search-forward-end \
                 '^[OB' history-beginning-search-forward-end
bindkey -M viins '^[[A' history-beginning-search-backward-end \
                 '^[OA' history-beginning-search-backward-end \
                 '^[[B' history-beginning-search-forward-end \
                 '^[OB' history-beginning-search-forward-end

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#> Autocomplete

autoload -U +X bashcompinit && bashcompinit

# terraform:
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# kubectl:
source <(kubectl completion zsh)

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#> Language Support

# Golang
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# Rust
source ~/.cargo/env

# NVM (NodeJS)
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#> Editor

# Neovim
export VISUAL="nvr" 

# Aliases
alias vi=nvim
alias vim=nvim

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
