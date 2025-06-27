# Run In Shell

This repository contains a set of scripts that allow you to execute source code files in various programming languages, including C, C++, Java, JavaScript, Lua, and Python.
The scripts work on both Linux and Windows operating systems. Since they are shell scripts, they should work on macOS as well. However, this guide currently focuses on Windows and Linux environments.

## Table of Contents

* [Linux Setup](#linux-setup)

  * [Installation](#installation)
* [Windows Setup](#windows-setup)

  * [Installation](#installation-1)
  * [Manual Installation](#manual-installation)
* [VS Code Integration](#vs-code-integration)
* [Usage](#usage)

---

## Linux Setup

### Installation

1. Create a folder named `myscripts` in your home directory:

   ```bash
   mkdir ~/myscripts
   ```

2. Copy the `run.sh` and `runf.sh` scripts into the `myscripts` folder after downloading them from this repository.

3. Add the following aliases to your shell configuration file (e.g., `.bashrc` or `.zshrc`):

   ```bash
   alias run="bash ~/myscripts/run.sh"
   alias runf="bash ~/myscripts/runf.sh"
   ```

4. If you encounter any execution permission errors, make the scripts executable:

   ```bash
   chmod +x ~/myscripts/run.sh
   chmod +x ~/myscripts/runf.sh
   ```

5. Source your shell configuration file to apply the changes:

   ```bash
   source ~/.bashrc
   # or
   source ~/.zshrc
   ```

---

## Windows Setup

### Installation

For automatic installation, download the `run-in-shell-win-installer.ps1` file and run it in PowerShell by right-clicking the file (run as Administrator if necessary). If installation fails, follow the manual process described below.

### Manual Installation

1. Copy the script content and append it to your PowerShell `$PROFILE`. If you haven't previously created a profile, run the following command:

   ```powershell
   New-Item -Path $PROFILE -Type File -Force
   ```

2. Then open it using:

   ```powershell
   notepad $PROFILE
   ```

3. Paste the script inside the file and save.

4. Reload your PowerShell session to apply changes.

5. If you encounter a permission error regarding script execution, run the following (as Administrator):

   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

   Or, to enable for current user only:

   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

6. Restart your terminal.

---

Thanks for the clarification! Here's the updated final section of your `README.md`, now including instructions for setting up keyboard shortcuts via `keybindings.json` as well:

---

## VS Code Integration

To use these scripts via keyboard shortcuts inside Visual Studio Code:

### 1. Set Up `tasks.json`

1. Create a `.vscode` folder in the root of your project (if it doesn't already exist).
2. Place the provided `tasks.json` file into the `.vscode` folder.
3. This file defines two tasks:

   * **Run with run** → executes the file using `run`
   * **Run with runf** → executes the file using `runf` (uses `input.txt` and writes to `output.txt`)

> ⚠️ Ensure that the `run` and `runf` commands are globally available from your terminal before using them in VS Code.

---

### 2. Add Keyboard Shortcuts

By default you can use `Ctrl + Alt + B` to use `runf` (to compile and take input from `input.txt` and show output to `output.txt`). But if you want to bind the tasks to convenient keys like `Ctrl + Alt + [` and `Ctrl + Alt + ]`, you need to edit your `keybindings.json`. Otherwise the `run` command won't be avaialble to any keybindings.

#### Steps:

1. Open VS Code.

2. Go to:

   ```
   File → Preferences → Keyboard Shortcuts
   ```

3. Click the icon in the top-right corner that opens `keybindings.json` just on the left of split editor icon.

4. Append the following entries **to the array**, making sure to add a comma `,` if there's already one or more entries:

```json
{
    "key": "ctrl+alt+[",
    "command": "workbench.action.tasks.runTask",
    "args": "Run with run"
},
{
    "key": "ctrl+alt+]",
    "command": "workbench.action.tasks.runTask",
    "args": "Run with runf"
}
```

You can customize the keys to your liking.

> `tasks.json` only defines tasks, not their shortcuts — that's why you must edit `keybindings.json` separately.

---

With this setup, you’ll be able to run your source code files using the `run` and `runf` commands via keyboard shortcuts directly from VS Code — no need to open a terminal manually.

---

## Usage

### `run`

To compile and execute a source file and see output in the shell:

```bash
run <filename>
```

Example:

```bash
run test.cpp
```

This supports `.c`, `.cpp`, `.py`, `.js`, `.lua`, and `.java`. You can modify the script to support more languages as needed.

### `runf`

To compile and execute a file with input from `input.txt` and write output to `output.txt`:

```bash
runf <filename>
```

Example:

```bash
runf test.cpp
```
> [!WARNING]  
> Ensure `input.txt` and `output.txt` exist in the current directory, and the required compilers/interpreters are installed and available in your system's `PATH`.

---

These scripts are especially handy for competitive programming or quick prototyping when paired with Vim or VS Code workflows.

Happy Coding 😛

---
