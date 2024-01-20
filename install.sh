#!/bin/bash
#
# Script for managing config files from git repository
# by Karol Kozlowski
# https://github.com/KarolKozlowski

# List of managed config files
CONFIGS=()
CONFIGS+=(.inputrc .inputrc-sol) # inputrc
CONFIGS+=(.screenrc) # screen
CONFIGS+=(.vimrc .vim) # vim
CONFIGS+=(.bashrc-global) # bash
CONFIGS+=(.oh-my-zsh .zshrc) # zxh
CONFIGS+=(.gitconfig .gitignore-global) # git

# function for linking config files
link() {
  # takes 2 paremeters:
  source=$1
  destination=$2

  if [[ -L ${destination} ]]; then
    echo "${destination} link already exists"
  elif [[ -e ${destination} ]]; then
    echo "${destination} already exists but is not a link (inspect manually)"
    # TODO: automation for removing here, but:
    # inspection diff/inspection would be too cumbersome
  else
    if [[ -e ${source} ]]; then
      ln -s ${source} ${destination}
      echo "linked ${source} to ${destination}"
    else
      echo "ERROR: ${source} does not exist"
    fi
  fi
}

# save scripts directory
dotdir=$(dirname $(readlink -f $0))

# updatesubmodules
echo "Updating submodules in ${dotdir}"
git -C "${dotdir}" submodule init
git -C "${dotdir}" submodule update --remote --merge

# link files/dirs
for item in ${CONFIGS[*]}; do
  link ${dotdir}/${item} ~/${item}
done

bashrc=~/.bashrc
if grep -q '.bashrc-global' ${bashrc}; then
    echo "INFO: ~/.bashrc-global already sourced in ${bashrc}"
else
    echo "Adding bashrc-global to ${bashrc}"
    echo -e "\nif [ -f ~/.bashrc-global ]; then\n    source ~/.bashrc-global\nfi" >> ${bashrc}
fi
