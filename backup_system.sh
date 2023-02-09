#!/bin/bash
#
# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┑
# ┃ Back up script to be run before ./setup_system.sh on systems with existing   ┃
# ┃ configuration files. All files found in the .dotfiles directory will be      ┃ 
# ┃ moved to a backup directory.                                                 ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
#
#  Note: This script is part of my personal .dotfiles repository. The final step
#        utilizing stow to set up all the config files will only work if this is
#        cloned from my repository, or if you're running this script from your
#        own .dotfiles directory.
#

# Exit after first error
set -e

# Configures where all conflicting files will be moved to
BACKUP_DIR=$HOME/Backups

# Convenience function to make directories and move files
# Takes $1 as the path to the file to be moved
backup ()
{
   echo "Backing up $1"         
   BACKUP_FILE=$BACKUP_DIR/$1
   mkdir -p $(dirname $BACKUP_FILE)
   mv $HOME/$FILE $BACKUP_FILE
}

# Find all files in the current directory that:
#  1. Are not under the .git directory
#  2. Is not the .gitignore file
#  2. Are not shell scripts (such as this file)
#  3. Is not the README file
#  4. Is not the LICENSE file
#
#  (Basically, this has to find everything in this directory
#   that would be symlinked by stow when running setup_system.sh)
FILES=$(find . \
    -type f \
    ! -path "./.git/*" \
    ! -name ".gitignore" \
    ! -name "*.sh" \
    ! -name "README.md" \
    ! -name "LICENSE")

# Back up all files that already exist under $HOME to avoid conflicts
# when running stow later
for FILE in $FILES; do
    FILE=${FILE:2}  # Ignore the leading ./ in each file path
    if  [[ -f $HOME/$FILE ]]; then
        backup $FILE
    fi
done
