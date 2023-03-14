# config
My own config.

### Fonts
Using [JetBrainsMono](https://www.jetbrains.com/lp/mono/) font.

Use `fc-cache` after placing font in `~/.local/share/fonts/`

### MacOS stuff
Monitoring perf - https://github.com/exelban/stats

### PS1
https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh

Place in `~/` for this to read git branch

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

unmap /

map <c-e> visitPreviousTab
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

### Installing Jetbrains mono
`https://github.com/sabah1994/dotfiles/blob/90b74549d1303a9655ba18851e0042f11b81a4d9/scripts/installation.sh#L139`

```
install_font(){
    # insatll jetBrainsMono Nerd Font
    cd ~ && git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
    cd nerd-fonts
    git sparse-checkout add patched-fonts/JetBrainsMono install.sh
    ./install.sh JetBrainsMono
}
```
