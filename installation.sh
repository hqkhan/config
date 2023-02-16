#!/bin/bash

install_tmux() {
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

install_bash() {
    echo "==================================="
    echo "SETTING UP BASH"
    echo "==================================="

    ln -sf $HOME/config/bash/.bashrc $HOME/
    ln -sf $HOME/config/bash/.bash_func $HOME/
}

install_font() {
    # insatll jetBrainsMono Nerd Font
    cd $HOME && git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
    cd nerd-fonts
    git sparse-checkout add patched-fonts/JetBrainsMono install.sh
    ./install.sh JetBrainsMono
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
    cd $HOME
    git clone git@github.com:neovim/neovim.git
    cd neovim/
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install

    # echo "INSTALLING PACKER"
    # git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    #  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

    echo "INSTALLING NVIM CONFIG"
    ln -sf ~/config/nvim/.config/nvim ~/.config/nvim
}

install_git_conf() {
    ln -sf $HOME/config/git_prompt/.gitconfig $HOME/.gitconfig
    ln -sf $HOME/config/git_prompt/.git-prompt.sh $HOME/.git-prompt.sh 
}

install_cargo_tools() {
  echo "INSTALLING git-delta"
  cargo install git-delta
  echo "INSTALLING fd-find"
  cargo install fd-find
  echo "INSTALLING Ripgrep"
  cargo install ripgrep
  echo "INSTALLING bat"
  cargo install --locked bat
}

install_packages() {
    install_cargo
    install_git_conf
    install_tmux
    install_nvim
    install_fzf
    install_z
    install_cargo_tools
    install_bash
    # install_font
}

install_packages()
