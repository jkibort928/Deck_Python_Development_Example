#!/bin/bash

DIR=$(dirname $BASH_SOURCE)

SKIP_O=false
SKIP_K=false
CREATE_VENV=true

while getopts "hok" flag; do
	case $flag in
		h)
		echo "Available flags:"
		echo "  -h: Display this message"
		echo "  -o: Skip prompts (Overwrite)"
		echo "  -k: Skip prompts (Keep)"
		echo "    Note: the -o flag overpowers this"
		;;
		o)
		SKIP_O=true
		;;
		k)
		SKIP_K=true
		;;
	esac
done

error_exit()
{
	echo "$1" 1>&2
	exit 1
}

# Check if venv already exists
if [ -d $DIR/venv/ ]
then
	echo "There is a preexisting python virtural environment."
	if [ $SKIP_O = true ]
	then
		echo "Skipping prompt and removing old venv."	
		rm -rf $DIR/venv
	elif [ $SKIP_K = true ]
	then
		echo "Skipping prompt and keeping old venv."
		CREATE_VENV=false
	else
		echo "What would you like to do with it?"
		select choice in "Keep" "Overwrite" "Cancel"
		do
			case $choice in
				Keep)
				echo "Keeping existing venv folder..."
				CREATE_VENV=false
				break
				;;
				Overwrite)
				echo "Overwriting existing venv folder..."
				rm -rf $DIR/venv
				break
				;;
				Cancel)
				error_exit "User cancelled"
				;;
				*)
				echo "Please enter a number 1-3"
				;;
			esac
		done
	fi
fi


if [ $CREATE_VENV = true ]
then
	# Create venv
	echo "Creating python virtural environment..."
	python -m venv $DIR/venv
	if [ $? -eq 0 ]
	then
		echo "Successfully created python virtural environment."
	else
		error_exit "Unable to create python virtural environment!"
	fi
	
	# Install dependencies
	echo "Installing python dependencies..."
	$DIR/venv/bin/pip install --upgrade pip -r $DIR/requirements.txt
	
	if [ $? -eq 0 ]
	then
		echo "Successfully installed python dependencies."
	else
		error_exit "Unable to install python dependencies!"
	fi
fi

echo "The python virtural environment is all set up!"
