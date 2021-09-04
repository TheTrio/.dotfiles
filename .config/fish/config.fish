oh-my-posh --init --shell fish --config ~/.config/oh_my_posh/theme.json | source
# starship init fish | source
source ~/.bash_aliases
set fish_greeting
export PIPENV_VENV_IN_PROJECT=1
pokemon-colorscripts -r
status is-interactive; and pyenv init --path | source
pyenv init - | source
if status is-interactive
    # Commands to run in interactive sessions can go here
end

function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t $history[1]; commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end

