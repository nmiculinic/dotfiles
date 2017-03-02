export ZPLUG_HOME=$HOME/.zplug

if [[ ! -d $ZPLUG_HOME ]];then
  curl -sL zplug.sh/installer | zsh
fi
source $ZPLUG_HOME/init.zsh

# ruby
if which ruby > /dev/null && which gem >/dev/null; then
	PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
# zplug "zsh-users/zsh-autosuggestions"

#d prints the contents of the directory stack.
#1 ... 9 changes the directory to the n previous one.
zplug "zsh-users/prezto", use:"modules/{utility,directory,git,environment,terminal,editor,history,completion}"

if [ "$(hostname)" = "protagonist" ]; then
  zplug "zsh-users/prezto", use:"modules/zsh-notify"
fi
zplug 'eendroroy/alien-minimal', as:theme

zstyle ':prezto:module:terminal' auto-title 'yes'
zstyle ':prezto:module:terminal:window-title' format '%n@%m: %s'
zstyle ':prezto:module:editor' key-bindings 'vi'

export HISTSIZE=100000
export SAVEHIST=100000

zplug "plugins/wd",   from:oh-my-zsh
zplug "plugins/archlinux",   from:oh-my-zsh
zplug "plugins/pip",   from:oh-my-zsh
zplug "djui/alias-tips"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*linux*amd64*"

zplug "junegunn/fzf", use:""  # Just manage it... loading it manually later
zplug load #--verbose

zplug check --verbose
if [ ! $? -eq 0 ]; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

source $ZPLUG_REPOS/junegunn/fzf/shell/key-bindings.zsh

zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select
setopt completealiases
setopt HIST_IGNORE_DUPS

export PATH=$HOME/bin:/usr/local/bin:$ZPLUG_BIN:$PATH
export LANG=en_US.UTF-8
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export BROWSER=/usr/bin/google-chrome-stable

# Aliases
alias v=nvim
alias vi=nvim
alias vim=nvim
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias pb='pastebinit'
export VISUAL=nvim
export QT_QPA_PLATFORMTHEME=gtk2
export KEYTIMEOUT=1
#
unalias gl
gl() {
  git log --graph --color=always \
	  --pretty=format:"%C(auto)%h%d %s %C(green)%cn, %C(cyan)%cr%Creset" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
      --bind "ctrl-m:execute:
                echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R'"
}
