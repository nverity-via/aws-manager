#!/usr/bin/env bash

cp aws aws.old

echo "Updating aws script"

dir=$(pwd)
sed -i --expression "s@pathtothisdirectory@$dir@" aws
sed -i --expression "s@pathtothisdirectory@$dir@" aws.csv
sed -i --expression "s@pathtothisdirectory@$dir@" add_env

# update ~/.bashrc
bash_rc=~/.bashrc

ALIASCMD="alias awss='$dir/aws'"

echo "Making a backup of $bash_rc"
cp $bash_rc ~/.bashrc.backup

echo "
" >> $bash_rc
echo $ALIASCMD >> $bash_rc

echo "bashrc updated with 'awss' command"