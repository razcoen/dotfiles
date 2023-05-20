
function setup::shell() {
  source ~/shell/setup/env.sh
  source ~/shell/setup/aliases.sh
  plugins=(git emoji emotty)
  source $ZSH/oh-my-zsh.sh
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
}

function setup::completion() {
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /opt/homebrew/bin/terraform terraform
  source <(kubectl completion zsh)
  autoload -U compinit; compinit
}

function setup::node() {
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
}

setup::shell
setup::completion
setup::node
