oh-my-posh --init --shell fish --config ~/.config/oh_my_posh/theme.json | source
source ~/.bash_aliases
export PIPENV_VENV_IN_PROJECT=1
pokemon-colorscripts -r
if status is-interactive
    # Commands to run in interactive sessions can go here
end
