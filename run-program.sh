#!/bin/bash

DIR=$(dirname $BASH_SOURCE)

error_exit()
{
	echo "$1" 1>&2
	exit 1
}

# Ensure python virtural environment exists
/bin/bash $DIR/src/create-venv.sh -k #>/dev/null

if [ $? -eq 1 ] || [ ! -d $DIR/src/venv/ ]
then
	error_exit "Script create-venv.sh failed. Aborting."
fi

$DIR/src/venv/bin/python $DIR/src/main.py
