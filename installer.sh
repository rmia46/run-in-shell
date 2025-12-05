#!/bin/bash

# ====================================================================
# Run In Shell - Linux Installer Script
# Automates the setup of run and runf aliases and scripts.
# ====================================================================

REPO_RAW_URL="https://raw.githubusercontent.com/rmia46/run-in-shell/main"
# 1. CHANGE: Using a leading dot to hide the folder
SCRIPTS_DIR="$HOME/.myscripts" 
SHELL_CONFIG=""
SUCCESS=0

echo "Starting Run In Shell Installation..."

# --- 1. Determine the appropriate shell configuration file ---
if [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
    echo "Success: Detected Zsh configuration file: $SHELL_CONFIG"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
    echo "Success: Detected Bash configuration file: $SHELL_CONFIG"
else
    echo "Error: Could not find .bashrc or .zshrc. Aborting installation."
    exit 1
fi

# --- 2. Create the .myscripts directory ---
if [ ! -d "$SCRIPTS_DIR" ]; then
    # The output will now clearly show the creation of the hidden folder
    echo "Creating hidden script directory: $SCRIPTS_DIR" 
    mkdir -p "$SCRIPTS_DIR"
else
    echo "Script directory already exists: $SCRIPTS_DIR"
fi

# --- 3. Download the scripts ---
echo "Downloading run.sh and runf.sh..."
curl -fsSL "$REPO_RAW_URL/run.sh" -o "$SCRIPTS_DIR/run.sh"
if [ $? -ne 0 ]; then
    echo "Error: Failed to download run.sh. Check network connection or repository URL."
    exit 1
fi

curl -fsSL "$REPO_RAW_URL/runf.sh" -o "$SCRIPTS_DIR/runf.sh"
if [ $? -ne 0 ]; then
    echo "Error: Failed to download runf.sh. Check network connection or repository URL."
    exit 1
fi

# --- 4. Set execution permissions ---
echo "Setting execution permissions..."
chmod +x "$SCRIPTS_DIR/run.sh"
chmod +x "$SCRIPTS_DIR/runf.sh"

# --- 5. Add aliases to shell configuration ---
echo "Adding aliases to $SHELL_CONFIG..."

# 2. CHANGE: The aliases now point to the hidden folder
RUN_ALIAS="alias run='$SCRIPTS_DIR/run.sh'"
RUNF_ALIAS="alias runf='$SCRIPTS_DIR/runf.sh'"

# Function to check if alias exists
alias_exists() {
    grep -qF "$1" "$SHELL_CONFIG"
}

# Add or update the 'run' alias
if alias_exists "$RUN_ALIAS"; then
    echo "Alias 'run' already exists. Skipping."
else
    echo "$RUN_ALIAS" >> "$SHELL_CONFIG"
    SUCCESS=1
    echo "Added alias: run"
fi

# Add or update the 'runf' alias
if alias_exists "$RUNF_ALIAS"; then
    echo "Alias 'runf' already exists. Skipping."
else
    echo "$RUNF_ALIAS" >> "$SHELL_CONFIG"
    SUCCESS=1
    echo "Added alias: runf"
fi

# --- 6. Final Instructions ---
echo "----------------------------------------------------"
echo "Installation Complete!"

if [ $SUCCESS -eq 1 ]; then
    echo "ACTION REQUIRED: The new 'run' and 'runf' aliases are ready."
    echo "You must now apply them to your current session. Please copy and run the command below:"
    echo ""
    echo "    source $SHELL_CONFIG"
    echo ""
    echo "Alternatively, you can simply restart your terminal."
fi

echo "Happy Coding."
