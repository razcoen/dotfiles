export PATH=$PATH:$HOME/bin

# Node
export NVM_DIR=$HOME/.nvm

# Go
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# Git editor (neovim)
# About neovim remote: https://github.com/mhinz/neovim-remote
export VISUAL=nvim

# Oh My Zsh 
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="lambda-gitster" # https://github.com/ergenekonyigit/lambda-gitster

# getopt
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"