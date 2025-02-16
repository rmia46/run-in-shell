# Run In Shell

This repository contains a set of scripts that allow you to execute source code files in various programming languages, including C, C++, Java, JavaScript, Lua, and Python. 
The scripts work on both Linux and Windows operating systems. But as they are bash scripts they should work in mac too. I don't have a mac yet so, the guide here is only limited to windows and linux.

## Table of Contents

- [Linux Setup](#linux-setup)
  - [Installation](#installation)
- [Windows Setup](#windows-setup)
  - [Installation](#installation-1)
- [Usage](#usage)

## Linux Setup

### Installation

1. Create a folder named `myscripts` in your home directory:

   ```bash
   mkdir ~/myscripts
   ```

2. Copy the `run.sh` and `runf.sh` scripts into the `myscripts` folder after downlooading them from this repository.

3. Add the following aliases to your shell configuration file (e.g., `.bashrc` or `.zshrc`):

   ```bash
   alias run="bash /home/myscripts/run.sh"
   alias runf="bash /home/myscripts/runf.sh"
   ```

4. If you encounter any execution permission errors, make the scripts executable:

   ```bash
   chmod +x /home/myscripts/run.sh
   chmod +x /home/myscripts/runf.sh
   ```

5. Source your shell configuration file to apply the changes and you are done:

   ```bash
   source ~/.bashrc
   # or
   source ~/.zshrc
   ```

## Windows Setup

### Installation
Copy the source code and then append it to the powershell `$PROFILE` and you are done. But..

If you haven't previously created any profile run the following command in the powershell window.

```powershell
New-Item -path $PROFILE -type file -force
```
Then edit with notepad 
```powershell
notepad $PROFILE
```
Once notepad has opened the powershell profile paste the configuration there and save the file. `Reload` your powershell session to load the config.

If you get permission error about running scripts then run the following code as an administrator.
```powershell
Set-ExecutionPolicy RemoteSigned
```
Then restart terminal.

## Usage

### run
To run a file and get the output on the shell use-
```bash
run <filename>
```
For example to compile test.cpp file you need the command `run test.cpp`. Likewise you can run c, python, js, lua, java files. 
To add support for more languages you need to modify the configuration yourself. 

### runf
To run a file which might take input from `input.txt` and return the output on `output.txt` file use-
```bash
runf <filename>
```
For example to compile test.cpp file you need the command `runf test.cpp`. This will redirect the output to output.txt. 
> [!WARNING]  
> Make sure to create `input.txt` and `output.txt` files. And the compilers or interpreters must be installed on the system and avaialble to the system $PATH

For competitive programming with the combination of vim, these scripts come handy :)

Happy Coding!!!
