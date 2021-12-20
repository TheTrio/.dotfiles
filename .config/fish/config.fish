# oh-my-posh --init --shell fish --config /home/shashwat/.poshthemes/tonybaloney.omp.json | source
starship init fish | source
source ~/.bash_aliases
export PIPENV_VENV_IN_PROJECT=1
status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source
pokemon-colorscripts -r

set -x VISUAL "nvim"
set -x EDITOR "nvim"
set -x  MANPAGER "less -R --use-color -Dd+r -Du+b"
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
abbr g 'git'
abbr ga 'git add'
abbr gb 'git branch'
abbr gbl 'git blame'
abbr gc 'git commit -m'
abbr gca 'git commit --amend -m'
abbr gco 'git checkout'
abbr gcp 'git cherry-pick'
abbr gd 'git diff'
abbr gf 'git fetch'
abbr gl 'git log'
abbr gm 'git merge'
abbr gp 'git push'
abbr gpf 'git push --force-with-lease'
abbr gpl 'git pull'
abbr gr 'git remote'
abbr grb 'git rebase'
abbr gs 'git status'
abbr gst 'git stash'
abbr gsw 'git switch'
abbr xcopy 'xclip -sel copy'
