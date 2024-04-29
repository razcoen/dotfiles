function setup::aliases() {
  alias vi=nvim
  alias vim=nvim
  alias k=kubectl
  alias tf=terraform
  alias lnx="limactl shell --workdir=/home/razcohen.linux archlinux zsh"
}

function setup::baseenv() {
  export PATH=$PATH:$HOME/bin
  export VISUAL=nvim
  export ZSH=$HOME/.oh-my-zsh
  export ZSH_THEME="lambda-gitster" # https://github.com/ergenekonyigit/lambda-gitster
  export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
}

function setup::shell() {
  setup::baseenv
  setup::aliases
  plugins=(git emoji emotty docker docker-compose)
  source $ZSH/oh-my-zsh.sh
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -U +X bashcompinit && bashcompinit
  autoload -U compinit; compinit
}

function setup::nodejs() {
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  export NVM_DIR=$HOME/.nvm
}

function setup::java() {
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
}

function setup::go() {
  if command -v go &> /dev/null; then 
    GOPATH=$(go env GOPATH)
    export GOPATH
    export GOBIN=$GOPATH/bin
    export PATH=$PATH:$GOBIN
  fi
}

function setup::kubectl() {
  if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
  fi
}

function setup::terraform() {
  if command -v terraform &>/dev/null; then
    complete -o nospace -C /opt/homebrew/bin/terraform terraform
  fi
}

function setup::local() {
  if [[ -f ~/.local/share/shell/setup.sh ]]; then
    source ~/.local/share/shell/setup.sh
  fi
}

setup::shell

setup::kubectl
setup::terraform
setup::nodejs
setup::go
setup::java

setup::local
