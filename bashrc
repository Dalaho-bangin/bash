# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
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
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi


# Generated for pdtm. Do not edit.
export PATH=/root/.pdtm/go/bin:$PATH


export GITHUB_TOKEN=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
export FACEBOOK_COOKIE="datr=bJxnY1qn5KjKBaS62BGN9Na9; sb=bJxnY3MgkK9Iud7i41oHC2m_; c_user=100090165796071; xs=1%3AvaxUOJUzlZM9oA%3A2%3A1676337679%3A-1%3A-1%3A%3AAcXN0Nejeom5TR1tz5XAohBxulES0IxOK6QVB_3hkw; fr=0aPDlfGF7gIXMh9KZ.AWUmUzKbo-_PNHo9VrMbR6rAENg.Bj8Iqz.Mg.AAA.0.0.Bj8Iqz.AWXuD-4d0ok; dpr=4; presence=C%7B%22t3%22%3A%5B%5D%2C%22utc3%22%3A1676708533169%2C%22v%22%3A1%7D"
export WH_A_K=6e19e71047df5fcb4210c728921f7c5d8
alias rustscan='docker run -t --rm --name rustscan rustscan/rustscan:1.10.0'
source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash
export SHODAN_API_KEY=olj8BVTzKccQDbfyXSvYYzrrhQhaRW0J
. "$HOME/.cargo/env"
export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export VTAPIKEY=76575115455ea658f6433f4d856afea4a6dd7f564dc8ab0694d550feefdff92c

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
