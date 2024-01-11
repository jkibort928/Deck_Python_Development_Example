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

# Errors/Troubleshooting
**Error:** `bash: ./main.py: ./venv/bin/python: bad interpreter: No such file or directory`
**Explanation/Solution:** This error occurs because you tried to run `main.py` without first creating the python virtual environment. Either use `run-program.sh` to properly ensure it is created, or if you're stubborn, run the `create-venv.sh` script directly.
The python virtual environment lets us install things with *pip* in an isolated environment. We need to do this because we cannot modify the SteamOS filesystem.
