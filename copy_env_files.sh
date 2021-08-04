cp -r ~/.config/nvim/ ./.config/
cp -r ~/.config/i3/ ./.config/

rm -rf ./.config/nvim/plugged/
sudo rm -rf ./.config/nvim/lua-language-server/

cp ~/.tmux.conf .
cp ~/.bashrc .
cp ~/.dircolors .
cp ~/.inputrc .

cp ~/st/config.h .

cp ~/.config/nvim/plugged/gruvbox/colors/gruvbox.vim .

