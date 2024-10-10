#!/bin/bash

# Define backup directory
BACKUP_DIR="/tmp/backup_rm"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Get the current date and time for versioning
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Initialize arrays for files and directories, and options
FILES_TO_BACKUP=()
RM_OPTIONS=()

# Parse the arguments
for arg in "$@"; do
    if [[ "$arg" == -* ]]; then
        # If it's an option (starts with a dash), add to RM_OPTIONS
        RM_OPTIONS+=("$arg")
    else
        # Otherwise, it's a file or directory
        FILES_TO_BACKUP+=("$arg")
    fi
done

# Backup files and directories
for file in "${FILES_TO_BACKUP[@]}"; do
    if [ -e "$file" ]; then
        # Create a backup path in the backup directory
        backup_path="$BACKUP_DIR/${file}_$TIMESTAMP"

        # Move the file or directory to the backup location
        cp "$file" "$backup_path"
#        echo "Backed up '$file' to '$backup_path'"
    else
        # If -f (force) option is present, skip missing files
        if [[ ! " ${RM_OPTIONS[*]} " =~ " -f " ]]; then
            echo "rm: cannot remove '$file': No such file or directory"
        fi
    fi
done

# Execute the original rm command with the same options and files
/bin/rm "${RM_OPTIONS[@]}" "${FILES_TO_BACKUP[@]}"
