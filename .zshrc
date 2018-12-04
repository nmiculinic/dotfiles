export ZPLUG_HOME=$HOME/.zplug
if [[ ! -d $ZPLUG_HOME ]]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

source $ZPLUG_HOME/init.zsh

if [[ -f $HOME/.zshrc.local ]]; then
	source $HOME/.zshrc.local
fi

if [[ -d $HOME/fpath ]]; then
	fpath=($HOME/fpath $fpath)
fi

if [[ -d $HOME/go/bin ]]; then
	export PATH=$HOME/go/bin:$PATH
fi

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"

#d prints the contents of the directory stack.
#1 ... 9 changes the directory to the n previous one.
zplug "zsh-users/prezto", use:"modules/{utility,directory,git,environment,editor,history,completion}"

# zplug 'eendroroy/alien-minimal', as:theme
zplug "dracula/zsh", as:theme
zstyle ':prezto:module:editor' key-bindings 'vi'
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
zplug "plugins/kubectl",   from:oh-my-zsh
zplug "djui/alias-tips"
zplug "unixorn/git-extra-commands"
zplug "clvv/fasd", as:command, hook-build:"PREFIX=$HOME/.local make install
"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*linux*amd64*"

zplug "junegunn/fzf", use:"shell/key-bindings.zsh", defer:3
fpath=($HOME/.zplug/repos/littleq0903/gcloud-zsh-completion/src $fpath)

zplug load #--verbose
zplug check --verbose
if [ ! $? -eq 0 ]; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

export HISTSIZE=1000000
export SAVEHIST=1000000

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
export EDITOR=$(which nvim)
export VISUAL=$(which nvim)
export BROWSER=/usr/bin/google-chrome-stable

# Aliases
if which nvim > /dev/null; then
  alias v=nvim
  alias vi=nvim
  alias vim=nvim
else
  alias v=vim
  alias vi=vim
fi
alias pb='pastebinit'
alias dd='dd status=progress'
alias rg='ranger'
alias -g G='| grep '
alias t='tmux'

if ! [[ `uname` == "Darwin" ]]; then
    alias ls='ls --color=auto'
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi
alias gt='git tree'
export VISUAL=nvim
export QT_QPA_PLATFORMTHEME=gtk2
export KEYTIMEOUT=1
#
unalias gl
gppr() {
    # git push and pull request
    git push -u origin $(git rev-parse --abbrev-ref HEAD) && hub pull-request -b master
}

gl() {
  git log --graph --color=always \
	  --pretty=format:"%C(auto)%h%d %s %C(green)%cn, %C(cyan)%cr%Creset" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
      --bind "ctrl-m:execute:
                echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R'"
}

git_remove_merged() {
        git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

# if ([ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]) && [ -z "$TMUX" ]; then
#   tmux attach-session -t work || tmux new-session -s work
# fi

dri() { docker rmi $(docker images -q); }
alias ddrun='docker run --rm -it --user="`id -u`:`id -g`"'

export DE=gnome  #xdg-open bug
export HADOOP_CONF_DIR=/etc/hadoop
export HADOOP_PREFIX=/usr/lib/hadoop/
export JAVA_HOME=/usr/lib/jvm/java-8-jdk
export DOCKER_ID_USER="nmiculinic"

__docker_machine_ps1 () {
    if test ${DOCKER_MACHINE_NAME}; then
        printf -- "[%s] " "${DOCKER_MACHINE_NAME}"
    fi
}


ZSH_THEME="dracula"
PROMPT='$(__docker_machine_ps1)'"$PROMPT"

# added by travis gem
[ -f /home/lpp/.travis/travis.sh ] && source /home/lpp/.travis/travis.sh

# Kubernetes fix
if [ $commands[kubectl] ]; then
    source <(kubectl completion zsh)

    alias kge='kubectl get endpoints'
    alias kg='kubectl get'

__kube_namespace() {
    # printf -- "k8s [%s] " "$(kubectl config get-contexts | grep '^*' | sed -E 's/\s+/\t/g' | cut -f5)"
    printf -- "k8s [%s] " "$(kubectl config current-context)"
}
RPROMPT='$(__kube_namespace)'"$RPROMPT"
fi

if [ $commands[kompose] ]; then
  source <(kompose completion zsh)
fi

if [ $commands[helm] ]; then
  source <(helm completion zsh)
fi

export MINIKUBE_WANTUPDATENOTIFICATION=false  # To speed up shell start up time
if [ $commands[minikube] ]; then
  source <(minikube completion zsh)
fi

[ -f /opt/google-cloud-sdk/completion.zsh.inc ] && source /opt/google-cloud-sdk/completion.zsh.inc
alias kedit-secret="KUBE_EDITOR=kube-secret-editor kubectl edit secret"
export GOPATH=$HOME/go
alias pasteixio='curl -F "f:1=<-" ix.io'

# https://github.com/zsh-users/zsh-autosuggestions
bindkey '^ ' autosuggest-accept
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES



if [ $commands[terraform] ]; then
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C $(which terraform) terraform
fi
