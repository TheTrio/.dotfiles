oh-my-posh --init --shell fish --config ~/.config/oh_my_posh/theme.json | source
source ~/.bash_aliases
export PIPENV_VENV_IN_PROJECT=1
pokemon-colorscripts -r
status is-interactive; and pyenv init --path | source
pyenv init - | source
if status is-interactive
    # Commands to run in interactive sessions can go here
end
