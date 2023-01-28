HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

autoload -Uz compinit
compinit
eval "$(starship init zsh)"
source ~/.bash_aliases
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export NVM_DIR="$HOME/.nvm"
eval "$(pyenv init --path)"
