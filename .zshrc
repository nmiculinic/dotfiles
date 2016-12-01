export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# My primary framework is prezto.
# But I need some oh-my-zsh goodness
# thus I load it manually
#

zstyle ':completion:*' menu select
setopt completealiases

setopt HIST_IGNORE_DUPS
EDITOR=/usr/bin/nvim
BROWSER=/usr/bin/google-chrome-stable

bindkey -v

### DIRSTACK
# cd -N --> go to nth element in dir stack
# dirs | d --> view dir stack
# Persisting dir stack across sessions
# popd --> pop directory from stack and go to it
# http://zsh.sourceforge.net/Intro/intro_6.html
# Seem to have sane defaults in prezto

# Various includes
source /usr/share/fzf/key-bindings.zsh

if which ruby > /dev/null && which gem >/dev/null; then
	PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Aliases

alias v=nvim
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias pb='pastebinit'
