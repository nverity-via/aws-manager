#!/usr/bin/env bash

cp aws aws.old

echo "Updating aws script"

dir=$(pwd)
sed -i '' "s@pathtothisdirectory@$dir@" aws
sed -i '' "s@pathtothisdirectory@$dir@" aws.csv
sed -i '' "s@pathtothisdirectory@$dir@" add_env

# update ~/.zshrc
zsh_rc=~/.zshrc

ALIASCMD="alias awss='$dir/aws'"

echo "Making a backup of $zsh_rc"
cp $zsh_rc ~/.zshrc.backup

echo "
" >> $zsh_rc
echo $ALIASCMD >> $zsh_rc

echo "~/.zshrc updated with 'awss' command"
