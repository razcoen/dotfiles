#!/usr/bin/env zsh

FG_RED="\033[0;31m"
FG_GREEN="\033[0;32m"
FG_BLUE="\033[0;34m"
FG_WHITE="\033[0;37m"
FG_COMMENT="\033[0;38;5;242m"
FRAMES='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'

rm /tmp/dotfiles.log

################################################################
# Runner
################################################################

step=1
steps=0

function spinner() {
  local command=$(echo "$@")
  "$@" &>> /tmp/dotfiles.log &
  local pid=$! 
  local i=0
  while ps -p $pid > /dev/null
  do
    i=$(( i % $((${#FRAMES})) + 1 ))
    lim=$(tput cols)
    frame="${${(@z)FRAMES}[$i]//\"}"
    printf '\r%*.*b' ${#command} $lim "${FG_BLUE}$frame ${FG_COMMENT}($step/$steps) $command$(printf '%0.1s' " "{1..$lim})"
    sleep .05
  done
  printf "\r"
  wait $pid
  exit $?
}

declare -a cmds=()

function x() {
  cmds+=($@ ";")
  steps=$((steps+1))
}

function z() {
  cmd=()
  for arg in ${cmds[@]}; do
    if [[ $arg = ";" ]]; then
      y ${cmd[@]}
      cmd=()
    else
      cmd+=($arg)
    fi
  done
}

function y() { 
  local command=$(echo "$@")
  echo "${FG_BLUE}[X] ${FG_WHITE}$command" >> /tmp/dotfiles.log
  spinner "$@" &
  wait $!
  exit_code=$?
  echo -en "\033[1K"
  step=$((step+1))
  if [[ $exit_code -eq 0 ]]; then
    echo "${FG_GREEN}[OK] ${FG_WHITE}$command" >> /tmp/dotfiles.log
  else
    echo "${FG_RED}[FAIL] ${FG_WHITE}$command" >> /tmp/dotfiles.log
    exit 1
  fi
}

################################################################
# Installations
################################################################

if [[ ! $(command -v brew) ]]; then
    x /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else 
  x brew update
  x brew upgrade
fi

if [[ ! -d $HOME/.oh-my-zsh ]]; then
  x sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

formulaes=(zsh-autosuggestions)
if [[ ! $(command -v go) ]]; then
  formulaes=($formulaes[@] go)
fi
if [[ ! $(command -v nvim) ]]; then
  formulaes=($formulaes[@] neovim)
fi
if [[ ! $(command -v fzf) ]]; then
  formulaes=($formulaes[@] fzf)
fi
if [[ ! $(command -v git) ]]; then
  formulaes=($formulaes[@] git)
fi
if [[ ! $(command -v gh) ]]; then
  formulaes=($formulaes[@] gh)
fi
if [[ ! $(command -v tree) ]]; then
  formulaes=($formulaes[@] tree)
fi
if [[ ! $(command -v watch) ]]; then
  formulaes=($formulaes[@] watch)
fi
if [[ ! $(command -v rsync) ]]; then
  formulaes=($formulaes[@] coreutils)
fi
if [[ ! $(command -v lazygit) ]]; then
  formulaes=($formulaes[@] lazygit)
fi
if [[ ! -d $HOME/.nvm ]]; then
  formulaes=($formulaes[@] nvm)
fi
if [[ ! $(command -v rg) ]]; then
  formulaes=($formulaes[@] ripgrep)
fi

x brew install -q $formulaes[@]

if [[ ! $(command -v rustup) ]]; then
  x curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  x rustup update
fi

if [[ ! $(command -v alacritty) ]]; then
  x cargo install -q alacritty
  x sudo codesign --force --deep --sign - /Applications/Alacritty.app
else 
  x cargo install -q alacritty
fi

################################################################
# Dotfiles Linking
################################################################

DOTFILES=$(dirname $(realpath $0))

function symlink() {
  local source=$1
  local target=$2
  if [[ $(readlink -f $target) != $source ]]; then
    vared -p "Overwrite $target? [Y/n] " -c input
    if [[ ${input:-y}  =~ ^(y|Y)$ ]]; then
      x rm -rf $target
      x ln -s $source $target
    fi
  fi
}

x symlink $DOTFILES/.config/nvim $HOME/.config/nvim
x symlink $DOTFILES/.config/alacritty $HOME/.config/alacritty
x symlink $DOTFILES/.oh-my-zsh/custom $HOME/.oh-my-zsh/custom
x symlink $DOTFILES/.zshrc $HOME/.zshrc

x nvim --headless -c 'autocmd User PackerComplete quitall' -c 'silent PackerSync'

z
