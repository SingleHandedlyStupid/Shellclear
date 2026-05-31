#!/bin/bash

# Function to ask for confirmation
confirm_clear() {
    read -p "Do you want me to clear $1? (y/n): " choice
    case "$choice" in 
      y|Y ) return 0;;
      * ) return 1;;
    esac
}

echo "--- Starting Safe System Cleanup ---"

# 1. Clear User Cache (Safe but frees space)
if confirm_clear "User Cache (~/Library/Caches or ~/.cache)"; then
    echo "Cleaning caches..."
    # Example for macOS: rm -rf ~/Library/Caches/*
    # Example for Linux: rm -rf ~/.cache/*
    echo "Done."
fi

# 2. Clear Downloads Folder (Unused installers/pdfs)
if confirm_clear "the Downloads folder"; then
    echo "Emptying Downloads..."
    rm -rf ~/Downloads/*
    echo "Done."
fi

# 3. Empty the Trash
if confirm_clear "the Trash bin"; then
    echo "Emptying Trash..."
    # macOS path:
    rm -rf ~/.Trash/*
    echo "Done."
fi

echo "--- Cleanup Complete ---"
