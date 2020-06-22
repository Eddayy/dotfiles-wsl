#!/bin/bash

# things to I want to install 

source ./functions.sh


#install libs
install_if_not_exist git

function impl_zsh() {
    install_if_not_exist zsh
    ln2home shell-colors
    ln2home oh-my-zsh
    ln2home oh-my-zsh-custom
    ln2home zshrc
    ln2home zshrc_fzf
}


ln2home zshrc