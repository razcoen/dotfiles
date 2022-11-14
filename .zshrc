#############
# oh-my-zsh #
#############
if [ -f ${HOME}/.zplug/init.zsh ]; then
    source ${HOME}/.zplug/init.zsh
fi
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="nicoulaj"
plugins=(git)
source $ZSH/oh-my-zsh.sh

######
# go #
######
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

####################
# auto suggestions #
####################
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

################
# autocomplete #
################
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

#######
# nvm #
#######
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

########
# rust #
########
source ~/.cargo/env

##########
# neovim #
##########
export VISUAL="nvim" 

###########
# kubectl #
###########
source <(kubectl completion zsh)

###########
# aliases #
###########
alias vi=nvim
alias vim=nvim

