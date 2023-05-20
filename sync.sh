#!/usr/bin/env bash


SCRIPT_NAME=$(basename ${BASH_SOURCE[0]})
FORCE=false

while [[ $# -gt 0 ]]; do
  case $1 in
    -f|--force)
      FORCE=true
      shift # past argument
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

function sync_file() {
  local file=$1
  printf "syncing ~/%s\n" $file
  rm -rf $HOME/${file}.bak
  if [[ "$FORCE" = "true" ]]; then
    rm -rf $HOME/${file}
  else
    mv $HOME/${file} $HOME/${file}.bak
  fi
  ln -s $(pwd)/${file} $HOME/${file}
}


for file in * .[^.]*; do
  if [[ "$file" = "$SCRIPT_NAME" ]] || [[ "$file" = ".git" ]] ; then
    continue
  fi
  sync_file $file
done
