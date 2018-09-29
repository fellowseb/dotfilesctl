#! /bin/env bash

#
# dotfiles managements system installation script
#

BINARY="${PWD}"/$(dirname ${0})/bin/dotfilesctl
BINARY_INSTALL_DIR=$HOME/.local/bin
INSTALL_PATH="$BINARY_INSTALL_DIR"/$(basename $BINARY)

check_existing_install() {
  local DO_INSTALL=Y
  if [[ -e $INSTALL_PATH ]]; then
    read -p "Warning: The file $INSTALL_PATH exists, sure you want to override it ? (y/N) " DO_INSTALL
    DO_INSTALL=$(tr y Y <<< $DO_INSTALL)
  fi
  [[ $DO_INSTALL == 'Y' ]]
}

install_binary() {
  mkdir -p $BINARY_INSTALL_DIR &&
  cp $BINARY $INSTALL_PATH &&
  echo "Installed $INSTALL_PATH"
}  

set_exe() {
  chmod +x $INSTALL_PATH &&
  echo "Made $INSTALL_PATH executable"
}

add_to_path() {
  PATH=$PATH:${BINARY_INSTALL_DIR} &&
  echo "Added ${BINARY_INSTALL_DIR} to PATH in this shell" &&
  echo "Please use dotfilesctl to deploy a setup or modify .profile/.bashrc to make this change permanent"
}

install() {
  check_existing_install &&
  install_binary &&
  set_exe &&
  add_to_path &&
  echo "Done"
}

install
