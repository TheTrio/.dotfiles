export VISUAL=nvim
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export EDITOR="$VISUAL"
# enables color in man pages
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin"
source ~/.bashrc
if [ -f ~/.bashrc ]; then
        source ~/.bashrc
fi
eval "$(pyenv init --path)"
