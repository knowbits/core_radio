# How to get the Javascript-generated HTML (innerHTML) of the loaded page using "Chromium"

// TODO: GO THROUGH EVERYTHING: IT IS PROBABLY OUTDATED NOW...

NOTE: Chromium is maintained by Ubuntu

## Run this command to scrape the

`google-chrome --headless --dump-dom 'file:///..src/core_radio.html' > ./core_radio__scraped__without_javascript.html`

NOTE: This will give you the current state of the HTML as rendered by JavaScript, including any changes made after the page was loaded.

NOTE: This method requires "Chromium" to be installed on your system.

## HOW TO: Install "Chromium" on Ubuntu

```bash
# NOTE: On WSL 2 in Windows, you might also need to install a virtual GPU (vGPU)
# driver to benefit from hardware-accelerated OpenGL rendering.

# Consider first to Update WSL from Powershell / DOS:
# wsl --update
# wsl --shutdown

sudo apt update && sudo apt -y upgrade
sudo apt-get install chromium-browser
```

// TODO: GO THROUGH THIS and VERIFY THAT IT WORKS

## HOW TO: Create a Javascript-less version of the web page, containing only the HTML and CSS

Note that the `core_radio.html` file uses Javascript to create the HTML for the radio station buttons. The Javascript adds HTML to the DOM (innerHTML) during page load.

The resulting HTML it is only accessible after the page has loaded, by reading the innerHTML of the `radio-stations` div.

To get hold of the resulting generated HTML file (without any Javascript) we need to copy the "Outer HTML" of the loaded page.

There are a few ways to do this:

### Method 1 (manual): Copy the "Outer HTML" using the browser's "Developer Tools"

Here are the steps to copy the "Outer HTML" of the page to the clipboard, using the browser's "Developer Tools":

1. Open the static HTML file in your browser.
2. Open the browser's "Developer Tools" by pressing F12 or right-clicking on the page and selecting "Inspect".
3. In the "Developer Tools" window, select the "Elements" tab.
4. Right-click on the "html" tag in the "Elements" tab and select "Copy" > "Copy outerHTML".
   - _NOTE: This should work for the following browsers: Chrome, Firefox, Edge, Brave._
5. Paste the copied HTML into a new file and save it as "core_radio__without_javascript.html".

### Method 3 (manual): Browser extensions to get the outer HTML of a loaded web page

There maght also be browser extensions that can be used to copy the "Outer HTML" of a loaded page:

- TBD

### Method 3 (automated): Copy the "Outer HTML" using tools

Several tools are available to copy the "Outer HTML" of a page.

- Use Chrome in "headless mode":
  - `chrome --headless --disable-gpu --dump-dom 'file:///path/to/your/file.html' > core_radio__without_javascript.html`

CLI tools that can be used to "scrape" the "Outer HTML" from a loaded page:

- **Puppeteer:**
  - Puppeteer is a Node.js library which provides a high-level API to control Chrome or Chromium over the DevTools Protocol1. Puppeteer runs headless by default but can be configured to run full (non-headless) Chrome or Chromium. Puppeteer also requires: Node.ja, npm and Chrome or Chromium.

- **Selenium:**
  - Selenium is a powerful tool for controlling a web browser through the program. It is functional for all browsers, works on all major OS and its scripts are written in various languages i.e Python, Java, C#, etc. Selenium require Python ++.
