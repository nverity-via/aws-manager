#!/usr/bin/env bash

cat aws

cp aws aws.old

# TODO this
sed -i 's/pathtothisdirectory/'$(pwd)'/g' aws


exit 0

# update ~/.bashrc
bash_rc=~/.bashrc

echo "Making a backup of $bash_rc"
cp $bash_rc ~/.bashrc.backup

function update_bashrc() {

cat <<EOT >> $1

alias gp='git push && gitActionsStatus'
EOT

}

update_bashrc $bash_rc


exit 0


