starship init fish | source
string match -q "$TERM_PROGRAM" "vscode"
and . (code --locate-shell-integration-path fish)

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

set -gx VISUAL "nvim"
set -gx EDITOR "nvim"
set -gx  MANPAGER "less -R --use-color -Dd+r -Du+b"
set -gx GPG_TTY (tty)
set -gx TERM "xterm-256color"

set -g fish_greeting
set -e RUBY_VERSION

set -gx PIPENV_VENV_IN_PROJECT 1
fnm env --use-on-cd | source
status --is-interactive; and rbenv init - fish | source

function code
  set location "$PWD/$argv"
  open -n -b "com.microsoft.VSCode" --args $location
end

alias cat="bat"
