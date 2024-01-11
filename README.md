# Deck Python Development Example

These scripts/structures allow you to create an arbitrary python program and have it run on any linux system completely in userspace.

This was designed as a way to create python apps for the steamdeck, but can be used for other purposes.

# Instructions

**Step 1: Download**
Clone/Download this repository

**Step 2: Allow execution of `run-program.sh`**
To make it executable, you can do either of the following:
- **[Graphical]** Right click on the file called `run-program.sh` in `Dolphin File Manager` and select properties, then go to the `Permissions` tab. Then, check the "`Is executable`" box.
- **[Command-Line]** ***(Preferred)*** Open up a terminal window and navigate to the repository folder. Then, run the command `chmod u+x run-program.sh` (use u+x instead of +x because it's better practice)

Note: The first run of the program will be slow, as it needs to set up the python virtural environment (subsequent launches will be fast).

# Development

`./src/main.py` will be executed when `./run-program.sh` is ran. `./src/main.py` is your program, but you can use additional python scripts to better organize your code.

You can do anything you want in the `./src/` directory, except move/modify `./src/create-venv.sh` (unless you want to change its behavior)
You can create any amount of directories/subdirectories inside `./src/`, as well as include any files necessary for the operation of your program.

The `./src/` directory must contain a proper python requirements.txt file in order to install your dependencies.

Note: The `./src/` directory will contain a folder called `venv` once either `./run-program.sh` or `./src/create-venv.sh` is executed.

# Configuration

To add dependencies (pip packages), you first need to ensure the virtural environment is created (`./src/create-venv.sh`)
Then, use `./src/venv/bin/pip install <dependency>`, then run `./src/venv/bin/pip freeze > ./src/requirements.txt`

Alternatively, if you know the name and version of the packages you need, you can simply edit `./src/requirements.txt` manually.
To update pip packages before execution, you will need to run `./src/create-venv.sh -o` (the -o flag tells the script to overwrite the current venv if there is one)

# Errors/Troubleshooting
**Error:** `bash: ./main.py: ./venv/bin/python: bad interpreter: No such file or directory`
**Explanation/Solution:** This error occurs because you tried to run `main.py` without first creating the python virtual environment. Either use `run-program.sh` to properly ensure it is created, or if you're stubborn, run the `create-venv.sh` script directly.
The python virtual environment lets us install things with *pip* in an isolated environment. We need to do this because we cannot modify the SteamOS filesystem.


#TODO: MAKE A WAY TO TELL IF REQUIREMENTS.TXT CHANGED AND MAKE THE SCRIPT OVERWRITE THE VENV
maybe save a snapshot of requirements.txt and use diff
