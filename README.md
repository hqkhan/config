# config
My own config.

### Install `neovim`
sudo apt-get install neovim

### To get dircolors files in your home
`dircolors -p > ~/.dircolors`

Then in your ~/.bashrc file add the lines:

`eval "\`dircolors -b ~/.dircolors\`"`

### Fonts
Using [JetBrainsMono](https://www.jetbrains.com/lp/mono/) font.

Use `fc-cache` after placing font in `~/.local/share/fonts/`

### LSP
#### Compile Lua
https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

```
cd 3rd/luamake
compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild
```

### PS1
https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh

Place in `~` for this to read git branch
