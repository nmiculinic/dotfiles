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
zplug "zsh-users/prezto", use:"modules/{utility,directory,git,environment,editor,history,completion}"

if [ "$(hostname)" = "protagonist" ]; then
  zplug "zsh-users/prezto", use:"modules/{zsh-notify,terminal}"
  zstyle ':prezto:module:terminal' auto-title 'yes'
  zstyle ':prezto:module:terminal:window-title' format '%n@%m: %s'
fi
zplug 'eendroroy/alien-minimal', as:theme

zstyle ':prezto:module:editor' key-bindings 'vi'

export HISTSIZE=100000
export SAVEHIST=100000

zstyle ':prezto:module:syntax-highlighting' highlighters \
  'main' \
  'brackets' \
  'pattern' \
  'cursor' \
  'root'


zplug "plugins/wd",   from:oh-my-zsh
zplug "plugins/archlinux",   from:oh-my-zsh
zplug "plugins/pip",   from:oh-my-zsh
zplug "plugins/colored-man-pages",   from:oh-my-zsh
zplug "plugins/fasd",   from:oh-my-zsh
zplug "djui/alias-tips"
zplug "clvv/fasd", as:command, hook-build:"PREFIX=$HOME/.local make install
"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*linux*amd64*"

zplug "junegunn/fzf", use:"shell/key-bindings.zsh", defer:3
zplug load #--verbose

zplug check --verbose
if [ ! $? -eq 0 ]; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select
setopt no_complete_aliases
setopt HIST_IGNORE_DUPS

for p in "$HOME/.local/bin" "$HOME/bin" "$ZPLUG_BIN"; do
  if [ -d $p ]; then
    export PATH=$p:$PATH
  fi
done

for p in "$HOME/.local/man" "$HOME/.local/share/man"; do
  if [ -d $p ]; then
    export MANPATH=$p:$MANPATH
  fi
done


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

if ([ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]) && [ -z "$TMUX" ]; then
  tmux attach-session -t work || tmux new-session -s work
fi
