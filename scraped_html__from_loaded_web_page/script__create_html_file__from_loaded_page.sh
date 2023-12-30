#!/bin/bash

# Get the absolute directory of the script
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# Check if the HTML directory exists
if [ ! -d "$SCRIPT_DIR/../src/" ]; then
  echo "Directory $SCRIPT_DIR/../src/ does not exist."
  exit 1
fi

# Start the python simple web server to serve the static html page
# The server will run in the background on: http://localhost:8000
# NOTE: The web server will run in the background
#
(
  cd "$SCRIPT_DIR/../src/" && python3 -m http.server &
  echo $! >"$SCRIPT_DIR/python_server.pid"
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
  kill -9 "$(cat "$SCRIPT_DIR/python_server.pid")"
  rm "$SCRIPT_DIR/python_server.pid"
fi
