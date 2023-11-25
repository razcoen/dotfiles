function setup::shell() {
  source ~/.config/zsh/env.sh
  source ~/.config/zsh/aliases.sh
  plugins=(git emoji emotty docker docker-compose)
  source $ZSH/oh-my-zsh.sh
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /opt/homebrew/bin/terraform terraform
  source <(kubectl completion zsh)
  autoload -U compinit; compinit
}

function setup::node() {
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
}

function setup::local() {
  if [[ -f ~/.local/share/shell/setup.sh ]]; then
    source ~/.local/share/shell/setup.sh
  fi
}

setup::shell
setup::node
setup::local
