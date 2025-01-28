#!/bin/bash

# Define paths to extension directories
EXTENSIONS_DIRS=(
    "$HOME/.vscode-server-insiders/extensions"           # WSL path
    "/mnt/c/Users/erlen/.vscode-insiders/extensions"     # Windows 11 path
)

# Start JSON output
echo '{'
echo '  "name": "WSL and Windows Extensions Profile",'
echo '  "extensions": ['

# First extension flag to handle commas
first=true

# Array to keep track of processed IDs
declare -A processed_ids

# Loop through each extensions directory
for EXTENSIONS_DIR in "${EXTENSIONS_DIRS[@]}"; do
    # Check if directory exists
    if [ ! -d "$EXTENSIONS_DIR" ]; then
        echo "Directory not found: $EXTENSIONS_DIR" >&2
        continue
    fi

    # Process each extension in the directory
    for dir in "$EXTENSIONS_DIR"/*; do
        package_json="$dir/package.json"
        if [ -f "$package_json" ]; then
            # Extract relevant fields from package.json using grep and sed
            publisher=$(grep -m 1 '"publisher":' "$package_json" | sed 's/.*"publisher": *"\([^"]*\)".*/\1/')
            name=$(grep -m 1 '"name":' "$package_json" | sed 's/.*"name": *"\([^"]*\)".*/\1/')
            displayName=$(grep -m 1 '"displayName":' "$package_json" | sed 's/.*"displayName": *"\([^"]*\)".*/\1/')
            description=$(grep -m 1 '"description":' "$package_json" | sed 's/.*"description": *"\([^"]*\)".*/\1/')

            # Skip invalid entries
            if [[ -z "$publisher" || -z "$name" ]]; then
                continue
            fi

            # Fallback logic for displayName
            if [[ -z "$displayName" || "$displayName" =~ ^%.*%$ ]]; then
                if [[ -n "$description" && ! "$description" =~ ^%.*%$ ]]; then
                    displayName="$description"
                else
                    displayName="$name"
                fi
            fi

            # Initialize repo as empty string
            repo=""

            # Check for repository field as string or object
            if grep -q '"repository": *"[^"]*"' "$package_json"; then
                repo=$(grep -m 1 '"repository":' "$package_json" | sed 's/.*"repository": *"\([^"]*\)".*/\1/')
            elif grep -q '"repository": *{' "$package_json"; then
                repo=$(grep -m 1 '"repository":' -A 5 "$package_json" | grep -m 1 '"url":' | sed 's/.*"url": *"\([^"]*\)".*/\1/')
            fi

            # Validate and clean repository URL
            if [[ $repo == git+* ]]; then
                repo=${repo#git+}
            fi
            if [[ $repo == git://* ]]; then
                repo="https://${repo#git://}"
            fi
            if [[ $repo == git@* ]]; then
                repo="https://${repo#git@}"
                repo=${repo/:/\/}
            fi

            # Generate marketplace URL
            id="$publisher.$name"
            marketplace_url="https://marketplace.visualstudio.com/items?itemName=$id"

            # Skip if ID has already been processed
            if [[ -n "${processed_ids[$id]}" ]]; then
                continue
            fi
            processed_ids[$id]=1

            # Output extension info
            if [ "$first" = true ]; then
                first=false
            else
                echo ","
            fi

            cat << EOF
        {
          "id": "$id",
          "displayName": "$displayName",
          "marketplaceUrl": "$marketplace_url",
          "githubUrl": "$repo"
        }
EOF
        fi
    done
done

# Close extensions array and add settings
echo '  ],'
echo '  "settings": {'
echo '    "editor.tabSize": 2'
echo '  },'
echo '  "colorTheme": "Dark+ (default dark)"'
echo '}'


