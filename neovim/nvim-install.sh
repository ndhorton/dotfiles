#!/bin/env bash

if [[ "$1" == "--clean" ]]; then
        echo "Performing clean install..."
        if [[ -d "$HOME/.config/nvim" ]]; then
                rm -rf "$HOME/.config/nvim"
        fi
        if [[ -d "$HOME/.cache/nvim" ]]; then
                rm -rf "$HOME/.cache/nvim"
        fi
        if [[ -d "$HOME/.local/share/nvim" ]]; then
                rm -rf "$HOME/.local/share/nvim"
        fi
        if [[ -d "$HOME/.local/state/nvim" ]]; then
                rm -rf "$HOME/.local/state/nvim"
        fi
        if [[ -d "$HOME/.neovim" ]]; then
                rm -rf "$HOME/.neovim"
        fi
fi

if [[ -d "$HOME/.neovim" ]]; then
        echo "Updating Neovim..."
        cd "$HOME/.neovim"

        if [[ -d "$HOME/.neovim/build" ]]; then
                rm -rf "$HOME/.neovim/build"
        fi

        git checkout master
        git pull
else
        echo "Installing Neovim..."
        git clone https://github.com/neovim/neovim "$HOME/.neovim"
        cd "$HOME/.neovim"
fi

git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
make CMAKE_INSTALL_PREFIX="$HOME/.neovim" install

