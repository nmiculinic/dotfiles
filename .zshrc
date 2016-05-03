COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd.mm.yyyy"

plugins=(git tmux)

export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
autoload -Uz promptinit
promptinit

prompt walters

zstyle ':completion:*' menu select
setopt completealiases

setopt HIST_IGNORE_DUPS
EDITOR=/usr/bin/vim
BROWSER=/usr/bin/google-chrome-stable

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

### DIRSTACK
# cd -N --> go to nth element in dir stack
# dirs | d --> view dir stack
# Persisting dir stack across sessions
# popd --> pop directory from stack and go to it
# http://zsh.sourceforge.net/Intro/intro_6.html

DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
	dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
	[[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
	print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=10

setopt autopushd pushdsilent pushdtohome
setopt pushdignoredups
setopt pushdminus

# Various includes

. /etc/profile.d/fzf.zsh
. /usr/share/doc/pkgfile/command-not-found.zsh
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if which ruby > dev/null && which gem >/dev/null; then
	    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Aliases

alias s='du -sh * && du -sh' #summarize folder sizes
alias v=vim
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias pb='pastebinit'
