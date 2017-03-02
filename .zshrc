export ZPLUG_HOME=$HOME/.zplug
if [[ ! -d $ZPLUG_HOME ]];then
  curl -sL zplug.sh/installer | zsh
  source $ZPLUG_HOME/init.zsh
  zplug "nmiculinic/dotfiles", use:""
  zplug load --verbose
  zplug install
else
  source $ZPLUG_HOME/init.zsh
fi

source $ZPLUG_REPOS/nmiculinic/dotfiles/.zshrc.local
