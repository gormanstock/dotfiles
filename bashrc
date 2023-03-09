

###############################################################################
##########  Gitpod - prepend
###############################################################################

# Prompt color and bash_completion
export PS1='\[\e]0;\u \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w \$ \[\033[00m\]'
#source /etc/bash_completion

# editor config - should be removed when registry facade is default
if [ -z "$EDITOR" ]; then
    export EDITOR="gp open -w"
fi
if [ -z "$VISUAL" ]; then
    export VISUAL="$EDITOR"
fi
if [ -z "$GIT_EDITOR" ]; then
    export GIT_EDITOR="$EDITOR"
fi

# Workaround Java pre v10 by explicitly setting "-Xmx" for all Hotspot/openJDK VMs
if [ -n "$GITPOD_MEMORY" ]; then
    export JAVA_TOOL_OPTIONS="-Xmx${GITPOD_MEMORY}m";
fi

# Completion for gp command
. <(gp completion)
# ide cli config - should be removed when registry facade is default
if [ ! -d "/ide/bin/" ]; then 
    alias open='gp open'
    alias code='gp open'
fi

export GEM_HOME=/workspace/.rvm
export GEM_PATH=$GEM_HOME:$GEM_PATH
export PATH=/workspace/.rvm/bin:$PATH

export PIPENV_VENV_IN_PROJECT=true
export PIP_USER=yes
export PYTHONUSERBASE=/workspace/.pip-modules
export PATH=$PYTHONUSERBASE/bin:$PATH
unset PIP_TARGET
unset PYTHONPATH

# Set CARGO_HOME to reside in workspace if:
#  - it's RUNTIME (/workspace present)
if [ -d /workspace ]; then
    export CARGO_HOME=/workspace/.cargo
    export PATH=$CARGO_HOME/bin:$PATH
fi

export BROWSER="${BROWSER:=gp-preview}"

###############################################################################
##########  Gitpod - prepend
###############################################################################

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Place your own environment variables, aliases, customizations here
# (you can "unset" a previous variable if needed)

alias buildrunusim='./rops build all && ./bin/python ./source/simulation/usim2/usim2.py USim build && ./bin/python ./source/simulation/usim2/usim2.py USim build'

alias buildusim='./rops build all && ./bin/python ./source/simulation/usim2/usim2.py USim build'
alias runusim='./bin/python ./source/simulation/usim2/usim2.py USim run'

# Custom GIT PS1 function
function local_git_ps1 ()
{
    # This code drops the trailing space
    local prompt
    prompt=$(__git_ps1)
    short_prompt=${prompt:1}

    echo -e $short_prompt
}

# If we have the git_ps1 helper use it
if command -v __git_ps1 >/dev/null 2>&1  ; then

    # Define the options for the git PS1
    # WARNING: enabling some of these options can cause performance issues
    # on large repositories, leading to sluggish shell use.
    #GIT_PS1_SHOWDIRTYSTATE="y"
    #GIT_PS1_SHOWSTASHSTATE="y"
    #GIT_PS1_SHOWUNTRACKEDFILES="y"
    #GIT_PS1_SHOWUPSTREAM="verbose"

    # Update the standard Ubuntu PS1 with git information.
    PS1='\[\e[1;36m\]${debian_chroot:+($debian_chroot)}\u@\h:\[\e[m\e[1;33m\]$(local_git_ps1)\[\e[m\]\w\$ '
    tput bold
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


###############################################################################
##########  Gitpod - append - begin
###############################################################################


###############################################################################
##########  Gitpod - append - end
###############################################################################

