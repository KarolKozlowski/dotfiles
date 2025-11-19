#!/bin/bash
#
# save scripts directory
dotdir=$(dirname "$(readlink -f "$0")")

# updatesubmodules
echo "Updating submodules in ${dotdir}"
git -C "${dotdir}" submodule init
git -C "${dotdir}" submodule update --remote --merge

