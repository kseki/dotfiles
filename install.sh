#!/bin/sh

DOTPATH=~/.dotfiles
GITHUB_URL=git@github.com:kota718/dotfiles.git

if hash "git"; then
  git clone --recursive "$GITHUB_URL" "$DOTPATH"

elif hash "curl" || hash "wget"; then
  tarball "https://github.com/kota718/dotfiles/archive/master.tar.gz"
  
  if hash "curl"; then
    curl -L "&tarball"

  elif hash "wget"; then
    wget -o - "$tarball" 
  
  fi | tar xv -
  
  mv -f dotfiles-master "$DOTPATH"

else
  die "curl or wget required"
fi

cd ~/.dotfiles
if [ $? -ne 0 ]; then
  die "not found: $DOTPATH"
fi


for f in .??*
do
  [ "$f" = ".git" ] && continue

  ln -snfv "$f" "$HOME"/"$f"
done

