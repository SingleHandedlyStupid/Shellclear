#!/bin/bash

# Function to ask for confirmation
confirm_clear() {
    printf "Do you want to clear %s? (y/n): " "$1"
    read -r choice
    case "$choice" in 
      y|Y ) return 0;;
      * ) return 1;;
    esac
}

# Ensure we are actually on a Mac before running
if [ "$(uname)" != "Darwin" ]; then
    echo "Error: This script is strictly optimized for macOS."
    exit 1
fi

echo "--- Starting Safe Mac Cleanup ---"

# 1. Clear User Cache (Safely targets app subfolders, skips system files)
if confirm_clear "User App Caches (~/Library/Caches)"; then
    echo "Cleaning caches..."
    if [ -d "$HOME/Library/Caches" ]; then
        # Deletes the contents inside, but leaves the main folder intact
        find "$HOME/Library/Caches" -mindepth 1 -delete 2>/dev/null
    fi
    echo "Done."
fi

# 2. Clear Downloads Folder
if confirm_clear "the Downloads folder"; then
    echo "Emptying Downloads..."
    if [ -d "$HOME/Downloads" ]; then
        # Safely deletes items inside Downloads without destroying the main folder structure
        find "$HOME/Downloads" -mindepth 1 -delete 2>/dev/null
    fi
    echo "Done."
fi

# 3. Empty the Trash
if confirm_clear "the Trash bin"; then
    echo "Emptying Trash..."
    if [ -d "$HOME/.Trash" ]; then
        find "$HOME/.Trash" -mindepth 1 -delete 2>/dev/null
    fi
    echo "Done."
fi

# 4. OPTIONAL: Clear System Logs (Safe to delete, text files only)
if confirm_clear "User Log Files (~/Library/Logs)"; then
    echo "Cleaning log files..."
    if [ -d "$HOME/Library/Logs" ]; then
        find "$HOME/Library/Logs" -mindepth 1 -delete 2>/dev/null
    fi
    echo "Done."
fi

echo "--- Cleanup Complete ---"
