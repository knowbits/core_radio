#!/usr/bin/env bash
# Sets up a Linux dev host for the Tauri 2 desktop app (build__tauri_app/). Idempotent: run it
# again at any time; it installs only what is missing.
#
#   1. System libraries Tauri 2 links against (WebKitGTK 4.1, GTK 3, libsoup 3, ...) -- needs sudo.
#      Package lists: https://v2.tauri.app/start/prerequisites/#linux
#   2. Rust via rustup (the toolchain itself is pinned by src-tauri/rust-toolchain.toml).
#   3. Node via mise (pinned by mise.toml at the repo root).
#   4. npm dependencies of the app (npm ci).
#
# Usage: build__tauri_app/scripts/bootstrap-linux-dev-env.sh [--check]
#   --check  only report what is missing; change nothing (exit 1 if anything is missing)
set -euo pipefail

APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_DIR="$(cd "$APP_DIR/.." && pwd)"
CHECK_ONLY=0
[ "${1:-}" = "--check" ] && CHECK_ONLY=1

# pkg-config modules Tauri 2 needs at build time; present = the system step has nothing to do.
PC_MODULES=(webkit2gtk-4.1 javascriptcoregtk-4.1 gtk+-3.0 libsoup-3.0 glib-2.0 librsvg-2.0 openssl)

say() { printf '[bootstrap] %s\n' "$*"; }
missing=0

system_libs_present() {
    command -v pkg-config >/dev/null && pkg-config --exists "${PC_MODULES[@]}" 2>/dev/null &&
        command -v cc >/dev/null
}

install_system_libs() {
    if command -v apt-get >/dev/null; then
        sudo apt-get update
        sudo apt-get install -y libwebkit2gtk-4.1-dev build-essential curl wget file libxdo-dev \
            libssl-dev libayatana-appindicator3-dev librsvg2-dev pkg-config
    elif command -v dnf >/dev/null; then
        sudo dnf check-update || true
        sudo dnf install -y webkit2gtk4.1-devel openssl-devel curl wget file libappindicator-gtk3-devel \
            librsvg2-devel libxdo-devel pkgconf-pkg-config
        sudo dnf group install -y c-development
    elif command -v pacman >/dev/null; then
        sudo pacman -Syu --needed --noconfirm webkit2gtk-4.1 base-devel curl wget file openssl \
            appmenu-gtk-module libappindicator-gtk3 librsvg xdotool
    else
        say "unsupported package manager -- install the Linux prerequisites listed at"
        say "https://v2.tauri.app/start/prerequisites/#linux, then re-run this script"
        exit 1
    fi
}

# 1. System libraries
if system_libs_present; then
    say "system libraries: present ($(pkg-config --modversion webkit2gtk-4.1) webkit2gtk-4.1)"
elif ((CHECK_ONLY)); then
    say "system libraries: MISSING (pkg-config modules: ${PC_MODULES[*]})"
    missing=1
else
    say "system libraries: installing (sudo)"
    install_system_libs
    pkg-config --exists "${PC_MODULES[@]}" || { say "system libraries still missing after install"; exit 1; }
fi

# 2. Rust (rustup reads src-tauri/rust-toolchain.toml and installs that toolchain on first use)
if command -v rustup >/dev/null; then
    say "rustup: present"
    ((CHECK_ONLY)) || (cd "$APP_DIR/src-tauri" && rustup show active-toolchain >/dev/null)
elif ((CHECK_ONLY)); then
    say "rustup: MISSING"
    missing=1
else
    say "rustup: installing (https://rustup.rs, no PATH changes to your shell rc files)"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --default-toolchain none
    # shellcheck source=/dev/null
    . "$HOME/.cargo/env"
    (cd "$APP_DIR/src-tauri" && rustup show active-toolchain >/dev/null)
    say "rustup: add \"\$HOME/.cargo/bin\" to your PATH (or source \$HOME/.cargo/env) in your shell rc"
fi

# 3. Node (mise.toml at the repo root)
if command -v mise >/dev/null; then
    if ((CHECK_ONLY)); then
        if (cd "$REPO_DIR" && mise ls --missing --current 2>/dev/null | grep -q .); then
            say "mise tools: MISSING (run mise install)"
            missing=1
        else
            say "mise tools: present"
        fi
    else
        (cd "$REPO_DIR" && mise install)
        say "mise tools: installed (node)"
    fi
elif command -v node >/dev/null; then
    say "mise: not found -- using node $(node --version) from PATH (mise.toml pins the expected version)"
else
    say "node: MISSING -- install mise (https://mise.jdx.dev/getting-started.html) and re-run"
    missing=1
fi

# 4. npm dependencies
if ((CHECK_ONLY)); then
    if [ -d "$APP_DIR/node_modules/@tauri-apps/cli" ]; then
        say "npm dependencies: present"
    else
        say "npm dependencies: MISSING"
        missing=1
    fi
else
    (cd "$APP_DIR" && npm ci)
    say "npm dependencies: installed"
fi

if ((CHECK_ONLY)); then
    ((missing)) && { say "dev env incomplete -- run: just bootstrap"; exit 1; }
    say "dev env complete"
else
    say "done -- start the app: cd build__tauri_app && npm run tauri dev"
fi
