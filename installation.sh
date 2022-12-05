#!/bin/bash

setup_tmux() {
    echo "==================================="
    echo "INSTALLING TMUX "
    echo "==================================="
    git clone https://github.com/tmux/tmux.git
    cd tmux
    sh autogen.sh
    ./configure && make

    echo "==================================="
    echo "INSTALLING TPM"
    echo "==================================="
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    ln -sf $HOME/config/tmux/.tmux.conf $HOME/.tmux.conf
}

install_font() {
    # insatll jetBrainsMono Nerd Font
    cd $HOME && git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
    cd nerd-fonts
    git sparse-checkout add patched-fonts/JetBrainsMono install.sh
    ./install.sh JetBrainsMono
}

install_rg() {
    cargo install ripgrep
}

install_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    yes | ~/.fzf/install
}

install_z() {
    git clone git@github.com:rupa/z.git $HOME/z/
}

install_cargo() {
    curl https://sh.rustup.rs -sSf | sh
}

install_nvim() {
    echo "==================================="
    echo "INSTALLING NVIM"
    echo "==================================="
    local git_nvim_page="https://github.com/neovim/neovim/releases/tag/stable"
    local install_folder="$HOME/installation"
    echo "INSTALLING NVIM v0.8.1 from $git_nvim_page"
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz -P $install_folder
    cd $install_folder
    tar -xzvf nvim-linux64.tar.gz 
    ./nvim-linux64/bin/nvim

    echo "INSTALLING PACKER"
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim

    echo "INSTALLING NVIM CONFIG"
    ln -s ~/config/nvim ~/.config/nvim
}

install_git_conf() {
    ln -sf $HOME/config/git_prompt/.gitconfig $HOME/.gitconfig
    ln -sf $HOME/config/git_prompt/.git-prompt.sh $HOME/.git-prompt.sh 
}

install_packages() {
    install_cargo
    install_rg
    install_fzf
    install_z
    install_nvim
    install_font

}
