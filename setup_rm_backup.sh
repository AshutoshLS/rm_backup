#!/bin/bash

# Define paths
BACKUP_SCRIPT="$PWD/rm_backup.sh"
INSTALL_PATH="/usr/local/bin/rm_backup.sh"
BASHRC_FILE="$HOME/.bashrc"

# Check if the backup script exists
if [ ! -f "$BACKUP_SCRIPT" ]; then
    echo "Error: rm_backup.sh not found in the current directory."
    exit 1
fi

# Copy the script to /usr/local/bin
echo "Installing rm_backup.sh to /usr/local/bin..."
sudo cp "$BACKUP_SCRIPT" "$INSTALL_PATH"
sudo chmod +x "$INSTALL_PATH"
echo "Installation complete."

# Add the alias to the shell configuration file
if ! grep -q "alias rm='bash /usr/local/bin/rm_backup.sh'" "$BASHRC_FILE"; then
    echo "Adding alias to $BASHRC_FILE..."
    echo "alias rm='bash /usr/local/bin/rm_backup.sh'" >> "$BASHRC_FILE"
else
    echo "Alias for 'rm' already exists in $BASHRC_FILE."
fi

# Reload the shell configuration
echo "Reloading $BASHRC_FILE..."
# source "$BASHRC_FILE"
source ~/.bashrc

echo "Setup complete! 'rm' is now backed up in /tmp/backup_rm."
