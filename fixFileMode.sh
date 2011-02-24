#!/usr/bin/env bash
#######
# Repairs permissions on a web folder - Folders get 755, Files 644.
# Note: Just changes permissions, not owner.
# Usage: sudo ./fixFileMode.sh <target dir>
if [ $# -lt "1" ] || [ ! -d "$1" ]; then
    echo "Must indicate a proper directory."
    exit 2
fi
find $1 -type d -print0 | xargs -0 chmod 0755 # For directories
find $1 -type f -not -name "*.pl" -not -name "*.cgi" -not -name "*.sh" -print0 | xargs -0 chmod 0644 # For files
find $1 -type f -name "*.cgi" -print0 -o -name "*.pl" -print0 -o -name "*.sh" -print0 | xargs -0 chmod 0755 # For CGI/Scripts