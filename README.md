# config
My own config.

### Stow
`stow */` to grab all folders
`stow <folder_name>` to grab specific piece

### Install `neovim`
`sudo apt-get install neovim`

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

### Colorscheme
Place `palenight.yml` in `/home/hkhan/.config/nvim/plugged/nvcode-color-schemes.vim`

### VIMIUM
```
# Insert your preferred key mappings here.
map gh previousTab
map gl nextTab

unmap d
unmap J
unmap K
map J scrollFullPageDown
map K scrollFullPageUp

unmap o
unmap O

map o Vomnibar.activateInNewTab
map O Vomnibar.activateInNewTab

unmap `
map ' Marks.activateGotoMode


map <s-h> goBack
map <s-l> goForward

unmap t
map t Vomnibar.activateTabSelection

unmap b
map b Vomnibar.activateBookmarksInNewTab
```

```
w: https://www.wikipedia.org/w/index.php?title=Special:Search&search=%s Wikipedia

# More examples.
#
# (Vimium supports search completion Wikipedia, as
# above, and for these.)
#
g: https://www.google.com/search?q=%s Google
# l: https://www.google.com/search?q=%s&btnI I'm feeling lucky...
y: https://www.youtube.com/results?search_query=%s Youtube
gm: https://www.google.com/maps?q=%s Google maps
a: https://www.amazon.com/s/?field-keywords=%s Amazon
```
