#!/bin/zsh

MYMAC_CONFIG_PATH=$(cd $(dirname $0) || exit; pwd)
PLIST_PREFERENCES_PATH="$HOME/Library/Preferences"

# setup dotfiles
cd "$MYMAC_CONFIG_PATH/dotfiles" || (echo "error: $MYMAC_CONFIG_PATH/dotfiles not found. there may be something wrong. try re-clone this repository." && exit)

echo "******************"
echo "* setup dotfiles *"
echo "******************"
for dotfile (*) {
  if [[ -e "$HOME/.$dotfile" ]]; then
    echo -n "warning: '$HOME/.$dotfile' already exists. override it? (y/N): "
    if read -q; then
      ln -sfn "$MYMAC_CONFIG_PATH/dotfiles/$dotfile" "$HOME/.$dotfile"
      echo "\n[OK] create a symbolic link forcibly $MYMAC_CONFIG_PATH/dotfiles/$dotfile => $HOME/.$dotfile"
    else
      echo "\n[SKIP] create a symbolic link $MYMAC_CONFIG_PATH/dotfiles/$dotfile => $HOME/.$dotfile"
    fi
    continue
  fi

  ln -s "$MYMAC_CONFIG_PATH/dotfiles/$dotfile" "$HOME/.$dotfile"
  echo "[OK] create a symbolic link $MYMAC_CONFIG_PATH/dotfiles/$dotfile => $HOME/.$dotfile"
}

# setup app config
cd "$MYMAC_CONFIG_PATH/app" || (echo "error: $MYMAC_CONFIG_PATH/app not found. there may be something wrong. try re-clone this repository." && exit)

echo "**************************"
echo "* setup app config files *"
echo "**************************"
if [[ -e "$HOME/.vim" ]]; then
  echo -n "warning: '$HOME/.vim' already exists. override it? (y/N): "
  if ! read -q; then
    echo "\n[SKIP] create a symbolic link $MYMAC_CONFIG_PATH/app/vim => $HOME/.vim"
  else
    rm -rf "$HOME/.vim"
    ln -s "$MYMAC_CONFIG_PATH/app/vim" "$HOME/.vim"
    echo "\n[OK] create a symbolic link forcibly $MYMAC_CONFIG_PATH/app/vim => $HOME/.vim"
  fi
else
  ln -s "$MYMAC_CONFIG_PATH/app/vim" "$HOME/.vim"
  echo "[OK] create a symbolic link $MYMAC_CONFIG_PATH/app/vim => $HOME/.vim"
fi

# setup plists
cd "$MYMAC_CONFIG_PATH/plist" || (echo "error: $MYMAC_CONFIG_PATH/plist not found. there may be something wrong. try re-clone this repository." && exit)

echo "****************"
echo "* setup plists *"
echo "****************"
for plist (*) {
  if [[ -e "$PLIST_PREFERENCES_PATH/$plist" ]]; then
    echo -n "warning: '$PLIST_PREFERENCES_PATH/$plist' already exists. override it? (y/N): "
    if read -q; then
      ln -sf "$MYMAC_CONFIG_PATH/plist/$plist" "$PLIST_PREFERENCES_PATH/$plist"
      echo "\n[OK] create a symbolic link forcibly $MYMAC_CONFIG_PATH/plist/$plist => $PLIST_PREFERENCES_PATH/$plist"
    else
      echo "\n[SKIP] create a symbolic link $MYMAC_CONFIG_PATH/plist/$plist => $PLIST_PREFERENCES_PATH/$plist"
    fi
    continue
  fi

  ln -s "$MYMAC_CONFIG_PATH/plist/$plist" "$PLIST_PREFERENCES_PATH/$plist"
  echo "[OK] create a symbolic link $MYMAC_CONFIG_PATH/plist/$plist => $PLIST_PREFERENCES_PATH/$plist"
}
