#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

source ~/.git-prompt.sh
if [ "$color_prompt" = yes ]; then
    PS1='\[\e[0;1;38;5;113m\]-> \[\033[01;34m\]\w\[\033[00m\]\[\e[0;1;38;5;156m\]$(__git_ps1 " (%s)")\[\e[0;38;5;197m\] $\[\e[0m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add all ssh-keys 
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add `find $HOME/.ssh -not -name "*.pub" -name "id_*"`
fi

alias lg="git log --pretty="%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s" --all --graph --date=relative --date-order"
# export TERM=st-256color
export COLORTERM="truecolor"
alias ww="source ./venv/bin/activate"
# alias ff="flameshot full -c -p $PICTURE_PATH -d 3000"
alias ss="source ~/.bashrc"
export INPUTRC='~/.inputrc'
export DISPLAY="localhost:10.0"

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# --height=50% <- Adjust per command
# --layout=reverse <- Adjust per command
export FZF_DEFAULT_OPTS="--height=90% --info=inline --border --margin=1 --padding=1"

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--layout=reverse"
export FZF_CTRL_R_OPTS="--height=50%"

# Use fd to generate the list for directory completion
cd_with_fzf() {
    cd "$(fd --type d --hidden --follow --exclude "*.git" . "$PWD" | fzf $FZF_DEFAULT_OPTS --layout=reverse --preview="tree -C {} | head -200" -m)"
}

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# CTRL-G for changing directories
# bind '"\C-g":"cd_with_fzf\n"'
# OS-X
bind '"\C-g":"cd_with_fzf\C-M"'

