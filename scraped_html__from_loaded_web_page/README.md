# How to get the resulting HTML of the loaded page using "Chromium"

NOTE: Chromium is maintained by Ubuntu

## Run this command to scrape the 

`google-chrome --headless --dump-dom 'file:///..src/radio_streams_player.html' > ./radio_streams_player__scraped__without_javascript.html`

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



