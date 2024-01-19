# justfile

# ==============================================================================
# How to use "just" :
# Run these commands with "just <command>".
# For example: "just start" => To start the Electron app locally.
# ==============================================================================

# ==============================================================================
# INSTALL:
#
# 1. Use "cargo" to install "just", since it is a Rust app
#   $ sudo apt update; sudo apt install rustc
#   $ cargo install just
#
# 2. Add to ~/.bashrc or ~/.zshrc:
#   export PATH="$HOME/.cargo/bin:$PATH"
#
# 3. Verify version:
#    $ just --version""
#    Check against latest release: https://github.com/casey/just
# ==============================================================================

ELECTRON_BUILD_DIR := "./build__electron_app"

# Install dependencies
install:
    cd {{ELECTRON_BUILD_DIR}} && npm install

# Validate, minify, and prettify HTML
validate:
    bash ./{{ELECTRON_BUILD_DIR}}/script_prepare_static_html_for_electron_app.sh

# Start the Electron app locally
start: validate
    cd {{ELECTRON_BUILD_DIR}} && npm start

# Build the Electron app for different platforms and architectures
build-linux-Intel-x64: validate
    npm run dist-linux-Intel-x64

build-linux-Intel-ia32: validate
    npm run dist-linux-Intel-ia32

build-linux-ARM: validate
    npm run dist-linux-ARM

build-linux-ARM64: validate
    npm run dist-linux-ARM64

build-windows-x64: validate
    npm run dist-windows-x64

build-windows-ia32: validate
    npm run dist-windows-ia32

build-mac-on-Intel: validate
    npm run dist-mac-on-Intel

build-mac-on-M1: validate
    npm run dist-mac-on-M1

# Clean the project
clean:
    rm -f core_radio__processed_for_electron_app.html
    rm -rf tmp_html_processing
    rm -rf dist

# Test the project
test: install
    cd {ELECTRON_BUILD_DIR} && npm test
