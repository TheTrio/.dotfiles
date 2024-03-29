export VISUAL=nvim
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export EDITOR="$VISUAL"
# enables color in man pages
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin"
if [ -f ~/.bashrc ]; then
        source ~/.bashrc
fi
eval "$(pyenv init --path)"
. "$HOME/.cargo/env"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
