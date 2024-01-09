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

HTML_RESULT__STRIPPED_AND_VALIDATED="$TMP_FOLDER/tmp_10__step_1_result__html_stripped_and_validated.html"

# ========================================================
# Remove all Javascript type comments from the HTML page
#
# 1. First remove "comment blocks" that start with "/*" and end with "*/":
#
TMP_HTML_NO_JS_COMMENT_BLOCKS="$TMP_FOLDER/tmp_1_html_no_js_comment_blocks.html"

awk '
  BEGIN { multi_line_comment = 0; }
  /\/\*/ { multi_line_comment = 1; }
  /\*\// { multi_line_comment = 0; next; }
  !multi_line_comment { print; }
' "$HTML_SOURCE_FILE" >"$TMP_HTML_NO_JS_COMMENT_BLOCKS"

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
TMP_HTML_NO_JS_COMMENT_LINES="$TMP_FOLDER/tmp_2_html_no_js_comment_lines.html"

awk '{ if (!/:\//) sub(/\/\/.*/, ""); print }' \
  "$TMP_HTML_NO_JS_COMMENT_BLOCKS" \
  >"$TMP_HTML_NO_JS_COMMENT_LINES"
#
# { if (!/:\//) sub(/\/\/.*/, ""); print }
#   Replaces // and everything after it with nothing on each line,
#   and then prints the line, but only if the line does not contain :// (denoting a URL).
#   The ! operator negates the match, so !/:\// matches lines that do not contain ://

# ========================================================
# 3. Now remove all "HTML comment blocks" that start with "<!--" and end with "-->":

TMP_HTML_NO_HTML_COMMENT_BLOCKS="$TMP_FOLDER/tmp_3_html_no_html_comment_blocks.html"

awk '
  BEGIN { comment = 0; }
  /<!--/ { comment = 1; }
  /-->/ { comment = 0; next; }
  !comment { print; }
' "$TMP_HTML_NO_JS_COMMENT_LINES" >"$TMP_HTML_NO_HTML_COMMENT_BLOCKS"

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
TMP_4_HTML_PRETTIFIED="$TMP_FOLDER/tmp_4_html_prettified.html"
prettier "$TMP_HTML_NO_HTML_COMMENT_BLOCKS" >"$TMP_4_HTML_PRETTIFIED"

# ========================================================
# Validate the HTML with "W3C Markup Validation Service API" with "curl"
#
# NOTE: while the W3C Markup Validation Service can check the syntax of the CSS code
#       inside a <style> tag in an HTML file, it does not perform a full CSS validation.
# => For a full CSS validation, you would need to use a dedicated CSS validator
#    like the "W3C CSS Validation Service".

TMP_5_HTML_VALIDATION_RESULT="$TMP_FOLDER/tmp_5_html_validation_result_from_W3C_API.txt"

# URL of the W3C Markup Validation Service API
W3C_HTML_VALIDATION_API_URL="https://validator.w3.org/nu/"

# Make a POST request to the W3C API and save the response to a file
#
HTTP_STATUS=$(curl -s -o "$TMP_5_HTML_VALIDATION_RESULT" \
  -w "%{http_code}" -H "Content-Type: text/html; charset=utf-8" \
  --data-binary @"$TMP_4_HTML_PRETTIFIED" \
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
if grep -iq "Error:" "$TMP_5_HTML_VALIDATION_RESULT"; then
  echo "============================================"
  echo "HTML validation failed!"
  echo "For details: '$TMP_5_HTML_VALIDATION_RESULT'"
  exit 1
fi

# ========================================================
# First extract the CSS from the HTML file and save it to a .css file locally

TMP_6_CSS_EXTRACTED_FROM_HTML="$TMP_FOLDER/tmp_6_css_extracted_from_html.txt"

# Extract the CSS from the HTML file by removing everything before the first "<style>" tag
# and everything after the last "</style>" tag by using "awk"

awk '/<style>/{flag=1;next}/<\/style>/{flag=0}flag' \
  "$TMP_4_HTML_PRETTIFIED" \
  >"$TMP_6_CSS_EXTRACTED_FROM_HTML"

# ========================================================
# Validate the extracted CSS using "W3C CSS Validation Service" (online)

TMP_7_CSS_VALIDATION_RESULT="$TMP_FOLDER/tmp_7_css_validation_result_from_W3C_API.txt"

# URL of the W3C CSS Validation Service API
W3C_CSS_VALIDATION_API_URL="https://jigsaw.w3.org/css-validator/validator"

# Make a POST request to the W3C API and save the response to a file
# (Note: The "output" parameter is set to "text" to get the result as plain text)

HTTP_STATUS_CSS=$(curl -s -o "$TMP_7_CSS_VALIDATION_RESULT" \
  -w "%{http_code}" -F "file=@$TMP_6_CSS_EXTRACTED_FROM_HTML;type=text/css" \
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
if grep -q "<m:error>" "$TMP_7_CSS_VALIDATION_RESULT"; then
  echo "============================================"
  echo "CSS validation failed!"
  echo "For details: '$TMP_7_CSS_VALIDATION_RESULT'"
  exit 1
fi

# ========================================================
# First extract the Javascript from the HTML file and save it to a .js file locally

TMP_8_JAVASCRIPT_EXTRACTED_FROM_HTML="$TMP_FOLDER/tmp_8_javascript_extracted_from_html.js"

# Extract the Javascript from the HTML file by removing everything before the first "<script>" tag
# and everything after the last "</script>" tag by using "awk"

awk '/<script>/{flag=1;next}/<\/script>/{flag=0}flag' \
  "$TMP_4_HTML_PRETTIFIED" \
  >"$TMP_8_JAVASCRIPT_EXTRACTED_FROM_HTML"

# ========================================================
# Validate the Javascript using "eslint" (Node.js).
#
# To install "eslint" in your project: "$ npm install eslint"
#
# NOTE: The W3C provides validation services for HTML and CSS, but not for JavaScript.
#       So we use "eslint" to validate the Javascript code.

TMP_9_JS_VALIDATION_RESULT="$TMP_FOLDER/tmp_9_js_validation_result.txt"

if ! node "$NODE_BIN_FOLDER/eslint" "$TMP_8_JAVASCRIPT_EXTRACTED_FROM_HTML" >"$TMP_9_JS_VALIDATION_RESULT"; then
  echo "============================================"
  echo "Javascript validation failed!"
  echo "For details: '$TMP_9_JS_VALIDATION_RESULT'"
  exit 1
fi

# ========================================================
# Finally, write the processed HTML file to the Electron app's "build" folder.

cp "$TMP_4_HTML_PRETTIFIED" "$HTML_RESULT__STRIPPED_AND_VALIDATED"

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
echo "  $HTML_RESULT__STRIPPED_AND_VALIDATED"
echo ============================================
echo
