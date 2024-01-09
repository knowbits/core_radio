#!/bin/bash

# Get the absolute path of the current folder (this script's folder)
#
SCRIPT_FOLDER=$(
  cd "$(dirname "$0")" || exit
  pwd -P
)

# To be able to run locally installed node.js modules from this shell script:
#
NODE_BIN_FOLDER="$SCRIPT_FOLDER/node_modules/.bin"

# Create a tmp folder to store the differnet stages of the processed HTML file.
# Make sure to empty the folder if it already exists.
#
TMP_FOLDER="$SCRIPT_FOLDER/tmp_html_processing"

# Verify that "TMP_FOLDER" exists (Created by the "Step 1" script)

if [ ! -d "$TMP_FOLDER" ]; then
  echo "The 'TMP_FOLDER' folder, '$TMP_FOLDER', does not exist."
  echo "You need to run 'STEP 1' first: 'script__step_1__process_static_html__validate_and_strip_comments.sh'"
  exit 1
fi

# HTML_SOURCE_FILE="$TMP_FOLDER/tmp_10__step_1_result__html_stripped_and_validated.html"
HTML_SOURCE_FILE="$SCRIPT_FOLDER/../src/core_radio.html"

# Verify that "HTML_SOURCE_FILE" exists (Created by the "Step 1" script)
#
if [ ! -f "$HTML_SOURCE_FILE" ]; then
  echo "The 'HTML_SOURCE_FILE' file, '$HTML_SOURCE_FILE', does not exist."
  echo "You need to run 'STEP 1' first: 'script__step_1__process_static_html__validate_and_strip_comments.sh'"
  exit 1
fi

HTML_RESULT__ELECTRON_SPECIFIC_CODE_INSERTED="$SCRIPT_FOLDER/core_radio__electron_specific_code_inserted.html"

# Remove the resulting "HTML file" if it already exists
#
if [ -f "$HTML_RESULT__ELECTRON_SPECIFIC_CODE_INSERTED" ]; then
  rm "$HTML_RESULT__ELECTRON_SPECIFIC_CODE_INSERTED"
fi

# ========================================================
# Enable misc. pieces of Electron specific code in the HTML file
# ========================================================

TMP_11_UNCOMMENTED_ELECTRON_SPECIFIC_HTML_CODE="$TMP_FOLDER/tmp_11__uncommented_electron_specific_html_code.html"

# ========================================================
# 1. Uncomment the HTML to be used only in the Electron app.
#
# Start/end markers denote the HTML to be uncommented for use in the "Electron app" .
#
# Start marker: "<!-- UNCOMMENT_FOR_ELECTRON_APP_START"
# End marker:  "UNCOMMENT_FOR_ELECTRON_APP_END -->"
#
# NOTE: The whole line where these markers occur will deleted by this awk script:
#

awk '\
  !(/<!-- UNCOMMENT_FOR_ELECTRON_APP_START/ || /UNCOMMENT_FOR_ELECTRON_APP_END -->/)
  ' "$HTML_SOURCE_FILE" \
  >"$TMP_11_UNCOMMENTED_ELECTRON_SPECIFIC_HTML_CODE"

# ========================================================
# 2. Uncomment the Javascript to be used only in the Electron app.

TMP_12_UNCOMMENTED_ELECTRON_SPECIFIC_JAVASCRIPT_CODE="$TMP_FOLDER/tmp_12__uncommented_electron_specific_javascript_code.html"

# Start/end markers denote the Javascript to be uncommented for use in the "Electron app" .
#
# Start marker: "/* UNCOMMENT_FOR_ELECTRON_APP_START"
# End marker:  "UNCOMMENT_FOR_ELECTRON_APP_END /*"
#

# Remove the lines containing the "start" and "end" markers.
#
awk '\
  !(/\/\* UNCOMMENT_FOR_ELECTRON_APP_START/ || /UNCOMMENT_FOR_ELECTRON_APP_END \*\//)
  ' "$TMP_11_UNCOMMENTED_ELECTRON_SPECIFIC_HTML_CODE" \
  >"$TMP_12_UNCOMMENTED_ELECTRON_SPECIFIC_JAVASCRIPT_CODE"

exit 1

# ========================================================
# FINAL STEP: Pretty print the resulting HTML file using "prettier" (JavaScript).
#
# ABOUT: https://github.com/prettier/prettier
#        Pretty-prints HTML 5 files.
#        "Prettier is an opinionated code formatter."
#
# NOTE: To install "prettier" on Ubuntu (requires npm):
#       "$ sudo npm install --global prettier"
#       This will install Prettier globally, so you can use it from any directory on your system.
#
TMP_4_HTML_PRETTIFIED="$TMP_FOLDER/tmp_4_html_prettified.html"
TODO: NEEDS FIXING: prettier "$TMP_HTML_NO_HTML_COMMENT_BLOCKS" >"$TMP_4_HTML_PRETTIFIED"

# ========================================================
# Finally, write the processed HTML file to the Electron app's "build" folder.

cp "$TMP_4_HTML_PRETTIFIED" "$HTML_RESULT__ELECTRON_SPECIFIC_CODE_INSERTED"

# ========================================================
# Remove the temporary folder

# rm -rf "${TMP_FOLDER:?}"/*

# ========================================================
# Echo the result: Path of the final processed HTML file
echo
echo ============================================
echo "Removed all comments from the 'static HTML page':"
echo "  $HTML_SOURCE_FILE"

echo
echo "Resulting HTML file (no-comments, validated, pretty printed): "
echo "  $HTML_RESULT__ELECTRON_SPECIFIC_CODE_INSERTED"
echo ============================================
echo
