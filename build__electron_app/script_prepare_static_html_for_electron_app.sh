#!/bin/bash

# Get the absolute path of the current folder (this script's folder)
SCRIPT_FOLDER=$(
  cd "$(dirname "$0")" || exit
  pwd -P
)
# To be able to run locally installed node.js modules frmo shell script:
NODE_BIN_FOLDER="$SCRIPT_FOLDER/node_modules/.bin"

# Folder of static HTML page as "absolute path"
HTML_SOURCE_FOLDER="$(realpath "$SCRIPT_FOLDER/../src")"

# Verify that the HTML "src" folder exists
if [ ! -d "$HTML_SOURCE_FOLDER" ]; then
  echo "The HTML folder, '$HTML_SOURCE_FOLDER', does not exist."
  exit 1
fi

HTML_SOURCE_FILE="$HTML_SOURCE_FOLDER/core_radio.html"

# Create a tmp folder to store the differnet stages of the processed HTML file.
# Make sure to empty the folder if it already exists.
#
TMP_FOLDER="$SCRIPT_FOLDER/tmp_html_processing"
mkdir -p "$TMP_FOLDER"
rm -rf "${TMP_FOLDER:?}"/*

# ========================================================
# Enable misc. pieces of Electron specific code in the HTML file
# ========================================================

STEP_1_01_UNCOMMENTED_ELECTRON_SPECIFIC_HTML_CODE="$TMP_FOLDER/step_1_01__uncommented_electron_specific_html_code.html"

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
  >"$STEP_1_01_UNCOMMENTED_ELECTRON_SPECIFIC_HTML_CODE"

# ========================================================
# 2. Uncomment the Javascript to be used only in the Electron app.

STEP_1_02_UNCOMMENTED_ELECTRON_SPECIFIC_JAVASCRIPT_CODE="$TMP_FOLDER/step_1_02__uncommented_electron_specific_javascript_code.html"

# Start/end markers denote the Javascript to be uncommented for use in the "Electron app" .
#
# Start marker: "/* UNCOMMENT_FOR_ELECTRON_APP_START"
# End marker:  "UNCOMMENT_FOR_ELECTRON_APP_END /*"
#

# Remove the lines containing the "start" and "end" markers.
#
awk '\
  !(/\/\* UNCOMMENT_FOR_ELECTRON_APP_START/ || /UNCOMMENT_FOR_ELECTRON_APP_END \*\//)
  ' "$STEP_1_01_UNCOMMENTED_ELECTRON_SPECIFIC_HTML_CODE" \
  >"$STEP_1_02_UNCOMMENTED_ELECTRON_SPECIFIC_JAVASCRIPT_CODE"

# ========================================================
# Remove all Javascript type comments from the HTML page
#
# 1. First remove "comment blocks" that start with "/*" and end with "*/":
#
STEP_2_1_HTML_NO_JS_COMMENT_BLOCKS="$TMP_FOLDER/step_2_01_html_no_js_comment_blocks.html"

awk '
  BEGIN { multi_line_comment = 0; }
  /\/\*/ { multi_line_comment = 1; }
  /\*\// { multi_line_comment = 0; next; }
  !multi_line_comment { print; }
' "$STEP_1_02_UNCOMMENTED_ELECTRON_SPECIFIC_JAVASCRIPT_CODE" >"$STEP_2_1_HTML_NO_JS_COMMENT_BLOCKS"

# Explain the "awk" command:
#
#   BEGIN { multi_line_comment = 0; }
#     Initializes a variable multi_line_comment to 0.
#     This variable will be used to track whether we're inside a multi-line comment.
#
#   /\/\*/ { multi_line_comment = 1; }
#      Sets multi_line_comment to 1 when it encounters a line with "/*",
#      indicating the start of a multi-line comment.
#
#   /\*\// { multi_line_comment = 0; next; }
#     Sets multi_line_comment to 0 when it encounters a line with "*/",
#     indicating the end of a multi-line comment, and then skips to the next line.
#
#   !multi_line_comment { print; }
#     Prints the line if multi_line_comment is 0, meaning we're not inside a multi-line comment.

# 2. Then remove Javascript "single comment lines" that start with "//" and end with a newline character:
#
STEP_2_2_HTML_NO_JS_COMMENT_LINES="$TMP_FOLDER/step_2_02_html_no_js_comment_lines.html"

awk '{ if (!/:\//) sub(/\/\/.*/, ""); print }' \
  "$STEP_2_1_HTML_NO_JS_COMMENT_BLOCKS" \
  >"$STEP_2_2_HTML_NO_JS_COMMENT_LINES"
#
# { if (!/:\//) sub(/\/\/.*/, ""); print }
#   Replaces // and everything after it with nothing on each line,
#   and then prints the line, but only if the line does not contain :// (denoting a URL).
#   The ! operator negates the match, so !/:\// matches lines that do not contain ://

# ========================================================
# 3. Now remove all "HTML comment blocks" that start with "<!--" and end with "-->":

STEP_2_3_HTML_NO_HTML_COMMENT_BLOCKS="$TMP_FOLDER/step_2_03_html_no_html_comment_blocks.html"

awk '
  BEGIN { comment = 0; }
  /<!--/ { comment = 1; }
  /-->/ { comment = 0; next; }
  !comment { print; }
' "$STEP_2_2_HTML_NO_JS_COMMENT_LINES" >"$STEP_2_3_HTML_NO_HTML_COMMENT_BLOCKS"

# ========================================================
# Pretty print the resulting HTML file using "prettier" (JavaScript).
#
# ABOUT: https://github.com/prettier/prettier
#        Pretty-prints HTML 5 files.
#        "Prettier is an opinionated code formatter."
#
# NOTE: To install "prettier" on Ubuntu (requires npm):
#       "$ sudo npm install --global prettier"
#       This will install Prettier globally, so you can use it from any directory on your system.
#
STEP_2_4_HTML_PRETTIFIED="$TMP_FOLDER/step_2_04_html_prettified.html"
"$NODE_BIN_FOLDER/prettier" "$STEP_2_3_HTML_NO_HTML_COMMENT_BLOCKS" >"$STEP_2_4_HTML_PRETTIFIED"

# ========================================================
# Validate the HTML with "W3C Markup Validation Service API" with "curl"
#
# NOTE: while the W3C Markup Validation Service can check the syntax of the CSS code
#       inside a <style> tag in an HTML file, it does not perform a full CSS validation.
# => For a full CSS validation, you would need to use a dedicated CSS validator
#    like the "W3C CSS Validation Service".

STEP_2_5_HTML_VALIDATION_RESULT="$TMP_FOLDER/step_2_05_html_validation_result_from_W3C_API.txt"

# URL of the W3C Markup Validation Service API
W3C_HTML_VALIDATION_API_URL="https://validator.w3.org/nu/"

# Make a POST request to the W3C API and save the response to a file
#
HTTP_STATUS=$(curl -s -o "$STEP_2_5_HTML_VALIDATION_RESULT" \
  -w "%{http_code}" -H "Content-Type: text/html; charset=utf-8" \
  --data-binary @"$STEP_2_4_HTML_PRETTIFIED" \
  -X POST "$W3C_HTML_VALIDATION_API_URL?out=gnu")

# NOTE: The "out" parameter is set to "gnu" to get the result as "plain text".
# NOTE: The "--data-binary" option sends the data exactly as specified with
#       no extra processing, which is useful when the data is a binary file or similar.
#       This is important because any changes to the HTML code could affect the validation result.

# Check the HTTP status code fomr the "curl" call
#
if [ "$HTTP_STATUS" -ne 200 ]; then
  echo "HTTP request to W3C Validation Service API failed with status code: $HTTP_STATUS"
  exit 1
fi

# Check the HTML 5 validation result returned from the W3C API
#
if grep -iq "Error:" "$STEP_2_5_HTML_VALIDATION_RESULT"; then
  echo "============================================"
  echo "HTML validation failed!"
  echo "For details: '$STEP_2_5_HTML_VALIDATION_RESULT'"
  exit 1
fi

# ========================================================
# First extract the CSS from the HTML file and save it to a .css file locally

STEP_2_6_CSS_EXTRACTED_FROM_HTML="$TMP_FOLDER/step_2_06_css_extracted_from_html.txt"

# Extract the CSS from the HTML file by removing everything before the first "<style>" tag
# and everything after the last "</style>" tag by using "awk"

awk '/<style>/{flag=1;next}/<\/style>/{flag=0}flag' \
  "$STEP_2_4_HTML_PRETTIFIED" \
  >"$STEP_2_6_CSS_EXTRACTED_FROM_HTML"

# ========================================================
# Validate the extracted CSS using "W3C CSS Validation Service" (online)

STEP_2_7_CSS_VALIDATION_RESULT="$TMP_FOLDER/step_2_07_css_w3c_validation_result.txt"

# URL of the W3C CSS Validation Service API
W3C_CSS_VALIDATION_API_URL="https://jigsaw.w3.org/css-validator/validator"

# Make a POST request to the W3C API and save the response to a file
# (Note: The "output" parameter is set to "text" to get the result as plain text)

HTTP_STATUS_CSS=$(curl -s -o "$STEP_2_7_CSS_VALIDATION_RESULT" \
  -w "%{http_code}" -F "file=@$STEP_2_6_CSS_EXTRACTED_FROM_HTML;type=text/css" \
  -F "output=soap12" \
  -X POST "$W3C_CSS_VALIDATION_API_URL")

# Check the HTTP status code from the "curl" call
#
if [ "$HTTP_STATUS_CSS" -ne 200 ]; then
  echo "HTTP request to 'W3C CSS Validation Service' failed with status code: $HTTP_STATUS_CSS"
  exit 1
fi

# Consider: convert the SOAP 1.2 format to JSON format:
# xml2json < input.xml > output.json

# Check the CSS validation result returned from the W3C API
#
if grep -q "<m:error>" "$STEP_2_7_CSS_VALIDATION_RESULT"; then
  echo "============================================"
  echo "CSS validation failed!"
  echo "For details: '$STEP_2_7_CSS_VALIDATION_RESULT'"
  exit 1
fi

# ========================================================
# First extract the Javascript from the HTML file and save it to a .js file locally

STEP_2_8a_JAVASCRIPT_EXTRACTED_FROM_HTML="$TMP_FOLDER/step_2_08a_javascript_extracted_from_html.js"

# Extract the Javascript from the HTML file by removing everything before the first "<script>" tag
# and everything after the last "</script>" tag by using "awk"

awk '/<script>/{flag=1;next}/<\/script>/{flag=0}flag' \
  "$STEP_2_4_HTML_PRETTIFIED" \
  >"$STEP_2_8a_JAVASCRIPT_EXTRACTED_FROM_HTML"

# I need to remove indentation the Javascript code in the HTML file before validating it with "eslint"
# because "eslint" does not work on Javascript code that has wrong indentation.

# Remove superflous indentation from each line in the Javascript code using awk by removing 6 spaces from the beginning of each line.

STEP_2_8b_JAVASCRIPT__INDENTATION_FIXED="$TMP_FOLDER/step_2_08b_javascript_extracted_from_html__indentation_reduced_with_6_spaces.js"

"$NODE_BIN_FOLDER/prettier" \
  "$STEP_2_8a_JAVASCRIPT_EXTRACTED_FROM_HTML" \
  >"$STEP_2_8b_JAVASCRIPT__INDENTATION_FIXED"

# ========================================================
# Validate the Javascript using "eslint" (Node.js).
#
# To install "eslint" in your project: "$ npm install eslint"
#
# NOTE: The W3C provides validation services for HTML and CSS, but not for JavaScript.
#       So we use "eslint" to validate the Javascript code.

STEP_2_9_JS_VALIDATION_RESULT="$TMP_FOLDER/step_2_09_javascript_w3c_validation_result.txt"

if ! node "$NODE_BIN_FOLDER/eslint" "$STEP_2_8b_JAVASCRIPT__INDENTATION_FIXED" >"$STEP_2_9_JS_VALIDATION_RESULT"; then
  echo "============================================"
  echo "Javascript validation failed!"
  echo "For details: '$STEP_2_9_JS_VALIDATION_RESULT'"
  exit 1
fi

# ========================================================
# make a copy of the "pretty printed" HTML file (from above) to be used as the final result.
#
STEP_2_10_HTML_FINAL_RESULT="$TMP_FOLDER/step_2_10_html_final_result__copy_of_step_2_4.html"

cp "$STEP_2_4_HTML_PRETTIFIED" "$STEP_2_10_HTML_FINAL_RESULT"

# ========================================================
# Finally, write the processed HTML file to the Electron app's "build" folder.

HTML_RESULT__PROCESSED_FOR_ELECTRON_APP="$SCRIPT_FOLDER/core_radio__processed_for_electron_app.html"

cp "$STEP_2_10_HTML_FINAL_RESULT" "$HTML_RESULT__PROCESSED_FOR_ELECTRON_APP"

# ========================================================
# Echo the result: Path of the final processed HTML file
echo
echo ============================================
echo "Removed all comments from the 'static HTML page':"
echo "  $HTML_SOURCE_FILE"

echo
echo "Resulting HTML file (comments-stripped, W3C validated, pretty printed): "
echo "  $HTML_RESULT__PROCESSED_FOR_ELECTRON_APP"
echo ============================================
echo
