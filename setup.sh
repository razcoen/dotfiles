#!/usr/bin/env bash

set -e

BOLD=$(tput bold)
BOLD_RED="\e[1;31m"
BLUE="\e[0;34m"
GREY=$(tput setaf 244)
EC="\e[0m"

SCRIPT_NAME=$(basename ${BASH_SOURCE[0]})
SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})

function usage() {
  printf "\n"
  printf "${BOLD}Usage${EC}:\n\n"
  printf "${SCRIPT_NAME} [--force]\n"
  printf "\n"
  printf "${BOLD}Description${EC}:\n"
  printf "  Link all the dotfiles in the home directory to this repository dotfiles.\n"
  printf "  By default, the original dotfiles will be backed up with '*.bak' extension.\n"
  printf "\n"
  printf "${BOLD}Flags${EC}:\n"
  printf "  -f, --force         Link dotfiles forcefully, without backups.\n"
  printf "\n"
}

FORCE=false

# Parse flags:
while [[ $# -gt 0 ]]; do
  case $1 in
    -f|--force)
      FORCE=true
      shift
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done


function logf() {
  local message=$1
  printf "[%s] %b\n" "${SCRIPT_NAME}" "${message}"
}

function link_file() {

  local file=$1

  # Remove the backup file if exists.
  logf "  - Removing old backup"
  rm -rf $HOME/${file}.bak &> /dev/null || true

  # If the file trying to replace exist:
  # When using "--force" delete existing file or directory being linked.
  # Otherwise, move actual file to backup (e.g. .zshrc --> .zshrc.bak).
  if [[ -d ~/${file} ]] || [[ -f ~/${file} ]]; then
    if [[ "${FORCE}" = "true" ]]; then
      rm -rf ~/${file}
    else
      logf "  - Saving backup at ~/${file}.bak"
      mv ~/${file} ~/${file}.bak
    fi
  fi

  logf "  - Creating symbolic link"
  ln -s $(pwd)/${file} ~/${file}

}


logf "Linking dotfiles:"
for file in * .[^.]*; do
  # Link every file in this repository excluding:
  # 1. This script.
  # 2. ".git" directory.
  # 2. ".gitmodules" directory.
  if [[ "${file}" = "${SCRIPT_NAME}" ]] \
    || [[ "${file}" = ".git" ]] \
    || [[ "${file}" = ".gitmodules" ]] \
    ; then
    continue
  fi
  logf "${BOLD_RED}~/${file}${EC} -> ${BLUE}${SCRIPT_DIR}/${file}${EC}"
  link_file ${file}
done
