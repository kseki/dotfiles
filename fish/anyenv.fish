#anyenv

set -x PATH $HOME/.anyenv/bin $PATH
# eval (anyenv init - fish) # not working...

# rbenv
set -x RBENV_ROOT "$HOME/.anyenv/envs/rbenv"
set -x PATH $PATH "$RBENV_ROOT/bin"

set -gx PATH "$RBENV_ROOT/shims" $PATH
set -gx RBENV_SHELL fish
source "$RBENV_ROOT/libexec/../completions/rbenv.fish"
command rbenv rehash 2>/dev/null
function rbenv
  set command $argv[1]
  set -e argv[1]
  switch "$command"
  case rehash shell
    source (rbenv "sh-$command" $argv|psub)
  case '*'
    command rbenv "$command" $argv
  end
end

# pyenv
set -x PYENV_ROOT "$HOME/.anyenv/envs/pyenv"
set -x PATH $PATH "$PYENV_ROOT/bin"

set -gx PATH "$PYENV_ROOT/shims" $PATH
set -gx PYENV_SHELL fish
source "$PYENV_ROOT/completions/pyenv.fish"
command pyenv rehash 2>/dev/null
function pyenv
  set command $argv[1]
  set -e argv[1]
  switch "$command"
  case rehash shell
    source (pyenv "sh-$command" $argv|psub)
  case '*'
    command pyenv "$command" $argv
  end
end

# ndenv
set -x NDENV_ROOT "$HOME/.anyenv/envs/ndenv"
set -x PATH $PATH "$NDENV_ROOT/bin"

set -gx PATH "$NDENV_ROOT/shims" $PATH
set -gx NDENV_SHELL fish
#source "$PYENV_ROOT/completions/ndenv.fish"
command ndenv rehash 2>/dev/null
function ndenv
  set command $argv[1]
  set -e argv[1]
  switch "$command"
  case rehash shell
    source (ndenv "sh-$command" $argv|psub)
  case '*'
    command ndenv "$command" $argv
  end
end

# goenv
set -x GOENV_ROOT "$HOME/.anyenv/envs/goenv"
set -x PATH $PATH "$GOENV_ROOT/bin"

set -gx PATH "$GOENV_ROOT/shims" $PATH
set -gx GOENV_SHELL fish
source "$GOENV_ROOT/completions/goenv.fish"
command goenv rehash 2>/dev/null
function goenv
  set command $argv[1]
  set -e argv[1]
  switch "$command"
  case rehash shell
    source (goenv "sh-$command" $argv|psub)
  case '*'
    command goenv "$command" $argv
  end
end
