# run-powershell-config
###  This is a powershell script to run different source files like .c, .cpp, .lua etc. More like vs-codes code-runner extension.

## Installation
Copy the source code and then append it to the pwoershell `$PROFILE`

If you haven't previously created any profile run the following command in the powershell window.

```
New-Item -path $PROFILE -type file -force
```
Then edit with notepad 
```
notepad $PROFILE
```
Once notepad has opened the powershell profile paste the configuration there and save the file. Reload your powershell session to load the config.

## Usage
### run
To run a file and get the output on the shell use-
```
run <filename>
```
For example to compile test.cpp file you need the command `run test.cpp`. Likewise you are able to run c, python, js, ruby, lua, java files. To add support for more languages you need to modify the configuration yourself. 

### runp
To run a file which might take input from input.txt and return the output on output.txt file use-
```
runp <filename>
```
For example to compile test.cpp file you need the command `runp test.cpp`. This will redirect the output to output.txt. 
> [!WARNING]  
> Make sure to create `input.txt` and `output.txt` files.

I use this command for competitive programming. It's handy :)
