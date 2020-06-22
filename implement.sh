#!/bin/bash

source ./functions.sh

# Main
cd "$(dirname "$0")"

while getopts ":hTiuxs:c:" opt; do
    case $opt in
        h)
            show_help
            exit
            ;;
        T)
            echo "self test" >&2
            exit
            ;;
        i)
            check_repos

            echo "Initialize"

            echo "Step 1. Set dotfiles"
            set_dotfiles

            read -p "Do you want to configure zsh to your default shell [yY]?" -n 1
            if [[ $REPLY =~ ^[Yy]$ || ! $REPLY ]]; then
                conf_zsh
            fi

            read -p "Do you want to configure vim and its bundles [yY]?" -n 1
            if [[ $REPLY =~ ^[Yy]$ || ! $REPLY ]]; then
                conf_vim
            fi

            echo "\nAll done!"
            exit
            ;;
        u)
            FORCE_SET="true"

            echo "Update dotfiles"
            set_dotfiles

            exit
            ;;
        s)
            echo "Set $OPTARG"

            FORCE_SET="true"

            eval "impl_$OPTARG"

            exit
            ;;
        c)
            echo "Configure $OPTARG"

            eval "conf_$OPTARG"

            exit
            ;;
        x)
            echo "Delete all backup files"
            rm -f $HOME/.*.dotfilebak

            exit
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            exit 1
            ;;
    esac
done