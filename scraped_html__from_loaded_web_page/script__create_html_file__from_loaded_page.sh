#!/bin/bash

# Get the absolute directory of this script's folder
SCRIPT_DIR=$(
  cd "$(dirname "$0")"
  pwd -P
)

# Get the absolute path of the src directory
STATIC_HTML_FOLDER=$(realpath "$SCRIPT_DIR/../src/")

# Check if the HTML directory exists
if [ ! -d "$STATIC_HTML_FOLDER" ]; then
  echo "Directory $STATIC_HTML_FOLDER does not exist."
  exit 1
fi

# Start the python simple web server to serve the static html page
# The server will run in the background on: http://localhost:8000
# NOTE: The web server will run in the background
#
(
  cd "$STATIC_HTML_FOLDER" && python3 -m http.server &
  echo $! >"$SCRIPT_DIR/python_server.pid"

  # Wait until the server is responding
  until curl -s http://127.0.0.1:8000 >/dev/null; do
    echo "Waiting for the Python server to start..."
    sleep 1
  done

)
#
# => The PID is saved in the file: $SCRIPT_DIR/python_server.pid

# Set the CHROME_LOG_FILE environment variable
export CHROME_LOG_FILE="$SCRIPT_DIR/chrome_debug.log"

# Run Chromium in headless mode and navigate to a web page
chromium-browser \
  --headless=new \
  --disable-gpu \
  --no-sandbox \
  --virtual-time-budget=5000 \
  --disable-dev-shm-usage \
  --disable-software-rasterizer \
  --enable-logging --v=1 \
  --dump-dom 'http://127.0.0.1:8000/radio_streams_player.html' \
  >"$SCRIPT_DIR"/radio_streams_player__scraped_from_loaded_page.html

# Echo the result
echo
echo ============================================
echo "Scraped the loaded web page (with innerHTML from JavaScript))."
echo "Result was saved in: '$SCRIPT_DIR/radio_streams_player__scraped_from_loaded_page.html'"

# Instructions to view the file
echo
echo "To view the resulting html file, run: "
echo "   $ open $SCRIPT_DIR/radio_streams_player__scraped_from_loaded_page.html"
echo ============================================
echo

# Instructions to search the Chromium log file for "ERROR:" or "WARNING:"
echo ============================================
echo "To search the log file for error or warning, run: "
echo "   grep -E 'ERROR:|WARNING:' $SCRIPT_DIR/chrome_debug.log"
echo ============================================

# Check if the python web server process exists before killing it
if [ -f "$SCRIPT_DIR/python_server.pid" ]; then
  PID=$(cat "$SCRIPT_DIR/python_server.pid")
  if ps -p "$PID" >/dev/null; then
    kill -9 "$PID"
  fi
  rm "$SCRIPT_DIR/python_server.pid"
fi

# --------------------------------------------------
# Now remove the parts of the JavaScript that are not needed for the static page

# Remove the comment block preceding the "streams" array
sed -i '/\/\* START:/,/END: \*\//d' "$SCRIPT_DIR/radio_streams_player__scraped_from_loaded_page.html"

# Remove the "streams" array
sed -i '/const streams = \[/,/];/d' "$SCRIPT_DIR/radio_streams_player__scraped_from_loaded_page.html"

# Remove the "streams.forEach" loop, and replace it with the string "INSERT_SCRIPT_HERE"
sed -i '/streams.forEach(stream => {/,/});/c\INSERT_SCRIPT_HERE' "$SCRIPT_DIR/radio_streams_player__scraped_from_loaded_page.html"

# --------------------------------------------------
# Now replace the string "INSERT_SCRIPT_HERE" with a Javascript that adds
# event handlers to all the "audio stream buttons" on the scraped HTML page:

# --------------------------------------------------
# Now remove the parts of the JavaScript that are not needed for the static page

cat <<'EOF' >script_block.txt
      // Get all buttons
      const buttons = document.getElementsByTagName('button');

      // Loop through buttons and add event listener
      for (let i = 0; i < buttons.length; i++) {
        const audio = buttons[i].previousElementSibling;
        const url = buttons[i].getAttribute("title");

        // Check if the URL is not undefined or empty
        if (url) {
          buttons[i].addEventListener("click", function () {
            handleButtonClick(this, audio, url);
          });
        } else {
          console.error(`Button ${i} does not have a valid URL`);
        }
      }
EOF

# Then, use sed to replace "INSERT_SCRIPT_HERE" with the contents of script_block.txt:
sed -i '/INSERT_SCRIPT_HERE/{
    s/INSERT_SCRIPT_HERE//g
    r script_block.txt
}' "$SCRIPT_DIR/radio_streams_player__scraped_from_loaded_page.html"
