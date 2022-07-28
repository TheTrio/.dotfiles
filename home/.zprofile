export VISUAL=nvim
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export EDITOR="$VISUAL"
# enables color in man pages
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.rvm/bin"

#Wayland checks
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
    cd stow
    stow -D chromium_x11
    stow chromium_wayland
    stow code_wayland
else
    cd stow
    stow -D chromium_wayland
    stow chromium_x11
    stow -D code_wayland
fi

# makes firefox respect my default file manager
export GTK_USE_PORTAL=1
