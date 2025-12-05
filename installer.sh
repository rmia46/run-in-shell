#!/bin/bash

# ====================================================================
# Run In Shell - Linux Installer Script (With Colors)
# ====================================================================

# ANSI Color Codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m' # Brighter yellow for warnings/action items
RED='\033[0;31m'
RESET='\033[0m'    # Reset color to default

REPO_RAW_URL="https://raw.githubusercontent.com/rmia46/run-in-shell/main"
SCRIPTS_DIR="$HOME/.myscripts" 
SHELL_CONFIG=""
SUCCESS=0

echo -e "${GREEN}Starting Run In Shell Installation...${RESET}" # Green start message

# --- 1. Determine the appropriate shell configuration file ---
if [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
    echo -e "${GREEN}Success:${RESET} Detected Zsh configuration file: $SHELL_CONFIG"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
    echo -e "${GREEN}Success:${RESET} Detected Bash configuration file: $SHELL_CONFIG"
else
    echo -e "${RED}Error:${RESET} Could not find .bashrc or .zshrc. Aborting installation."
    exit 1
fi

# --- 2. Create the .myscripts directory ---
if [ ! -d "$SCRIPTS_DIR" ]; then
    echo "Creating hidden script directory: $SCRIPTS_DIR" 
    mkdir -p "$SCRIPTS_DIR"
else
    echo "Script directory already exists: $SCRIPTS_DIR"
fi

# --- 3. Download the scripts ---
echo "Downloading run.sh and runf.sh..."
curl -fsSL "$REPO_RAW_URL/run.sh" -o "$SCRIPTS_DIR/run.sh"
if [ $? -ne 0 ]; then
    echo -e "${RED}Error:${RESET} Failed to download run.sh. Check network connection or repository URL."
    exit 1
fi

curl -fsSL "$REPO_RAW_URL/runf.sh" -o "$SCRIPTS_DIR/runf.sh"
if [ $? -ne 0 ]; then
    echo -e "${RED}Error:${RESET} Failed to download runf.sh. Check network connection or repository URL."
    exit 1
fi

# --- 4. Set execution permissions ---
echo "Setting execution permissions..."
chmod +x "$SCRIPTS_DIR/run.sh"
chmod +x "$SCRIPTS_DIR/runf.sh"

# --- 5. Add aliases to shell configuration ---
echo "Adding aliases to $SHELL_CONFIG..."

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
    echo -e "${GREEN}Added alias: run${RESET}"
fi

# Add or update the 'runf' alias
if alias_exists "$RUNF_ALIAS"; then
    echo "Alias 'runf' already exists. Skipping."
else
    echo "$RUNF_ALIAS" >> "$SHELL_CONFIG"
    SUCCESS=1
    echo -e "${GREEN}Added alias: runf${RESET}"
fi

# --- 6. Final Instructions ---
echo "----------------------------------------------------"
echo -e "${GREEN}Installation Complete!${RESET}"

if [ $SUCCESS -eq 1 ]; then
    # Yellow for the Action Required warning
    echo -e "${YELLOW}ACTION REQUIRED:${RESET} The new 'run' and 'runf' aliases are ready."
    echo "You must now apply them to your current session. Please copy and run the command below:"
    echo ""
    # Highlight the source command itself in yellow
    echo -e "    ${YELLOW}source $SHELL_CONFIG${RESET}"
    echo ""
    echo "Alternatively, you can simply restart your terminal."
fi

echo "Happy Coding."
