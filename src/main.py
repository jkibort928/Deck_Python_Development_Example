#!./venv/bin/python

# ------------------------------------------
#   Packages n stuff
# ------------------------------------------

import os
import sys
script_directory = os.path.dirname(os.path.abspath(sys.argv[0]))

import tkinter as tk
from tkinter import *
from tkinter import scrolledtext
from PIL import ImageTk, Image


# ------------------------------------------
#   Wide scope variables
# ------------------------------------------

# Output window
output = None

# ------------------------------------------
#   Helper functions
# ------------------------------------------

def log(msg):
    print(msg)
    
    if not output:
        return

    # Check if we have scrolled away from the bottom
    is_scrolled = output.yview()[1] < 1.0

    output.configure(state=NORMAL)
    output.insert(END, msg + "\n")
    output.configure(state=DISABLED)

    # If we haven't manually scrolled up, follow the end
    if not is_scrolled:
        output.see(END)

counter = 0
def dostuff():
    global counter
    log("Spoob " + str(counter))
    counter += 1

# ------------------------------------------
#   GUI
# ------------------------------------------

# Main window
root = tk.Tk()
root.title("Spoob watches.....")
root.geometry("800x600")

# Title
title = Label(root,
                width=50,
                height=1,
                text="Spoob",
                font=("TkDefaultFont", 15),
                background="black",
                foreground="white")
title.pack(pady=5)

# Spoob
img = ImageTk.PhotoImage(Image.open(script_directory + "/imgs/spoob.png"))
panel = Label(root, image=img)
panel.pack()

# Button
button = Button(root,
                width=20,
                height=2,
                text="Spoob",
                command=dostuff)
button.pack(pady=5)

# Console frame
output_frame = Frame(root)
output_frame.pack(pady=5)

# Console
output = Text(output_frame, 
                width = 60,  
                height = 10,
                font = ("TkDefaultFont", 8),
                bg="light yellow",
                state=DISABLED) 
output.pack(side=LEFT, fill=BOTH)

# Console scrollbar
output_scroll = Scrollbar(output_frame, command=output.yview)
output_scroll.pack(side=RIGHT, fill=Y)

# Hook up the console to the scrollbar
output.config(yscrollcommand=output_scroll.set)

root.mainloop()
