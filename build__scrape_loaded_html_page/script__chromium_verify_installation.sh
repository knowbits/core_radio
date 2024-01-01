#!/bin/bash

# Get the absolute directory of the script
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# Run Chromium in headless mode and navigate to a web page
chromium-browser --headless --disable-gpu \
  --screenshot="$SCRIPT_DIR"/tmp/chromium_screenshot.png \
  --virtual-time-budget=5000 --window-size=1280x1024 \
  --no-sandbox --disable-software-rasterizer \
  --disable-dev-shm-usage 'https://www.vg.no' \
  >"$SCRIPT_DIR"/tmp/chromium_screenshot.png

# Echo the result
echo
echo ============================================
echo "Chromium (headless mode) took a screenshot of 'https://www.vg.no'"
echo "It was saved in: '$SCRIPT_DIR/tmp/chromium_screenshot.png'"

# Instructions to view the file
echo
echo "To view the saved image, run: "
echo "   $ fim -a $SCRIPT_DIR/tmp/chromium_screenshot.png"
echo
echo "View images from the terminal a CLI tool like 'fim'".
echo "NOTE: Install 'fim' by running: $ sudo apt install fim"
echo ============================================
echo
