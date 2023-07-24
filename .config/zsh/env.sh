export PATH=$PATH:$HOME/bin

# Node
export NVM_DIR=$HOME/.nvm

# Go
GOPATH=$(go env GOPATH)
export GOPATH
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# Git editor (neovim)
export VISUAL=nvim

# Oh My Zsh 
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="lambda-gitster" # https://github.com/ergenekonyigit/lambda-gitster

# GNU getopt
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
