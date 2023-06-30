# CIA-OS
The Operating System of the CIA machine. The most widely used computer.

# How to build.

Step 1: Install British.JS. You will likely use the CIA OS executable, otherwise check for Linus artifacts.

Step 2: Create a environment using the CIA SDK, if you haven't already, install it first. You can create an environment by typing:

```
anon@CIA ~ cia init -s -a
```

Step 3: Clone this repository using github, or alternatively from the official website. Extract the code and run:

```
anon@CIA ~ cia build -F
```

Step 4: Wait for the process to complete. Once done, you will have the source built, and in the case of flashing, an ISA file for CIA computers. For alternative builds, the building process will auto-create the file for your computer instead of the ISA.