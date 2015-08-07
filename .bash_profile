export PATH=/usr/local/bin:$PATH

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# .bashrc
test -r ~/.bashrc && . ~/.bashrc
