# core_radio

## CRITICAL — Mandatory Common Rules (always in force)

@../COMMON/AGENTS_COMMON_NO_AI_WORKFLOW.md

**Every rule and guideline in `../COMMON/AGENTS_COMMON_NO_AI_WORKFLOW.md` is MANDATORY in this repo** — the shared
behavioral core and Git safety rules for every repo under `~/DEV_REPOS/`. The `@` line above
imports it into Claude Code's context at session start (Claude Code never follows markdown
links); any other CLI/agent must read that file in full before doing any work here. This file
only adds project-specific rules and never overrides the common ones.

Internet-radio player as one static HTML page (Alpine.js + Shoelace), packaged as two desktop apps:
Electron and Tauri 2.

## Rules

- **Git:** read-only commands only (`status`, `log`, `show`, `diff`) unless the user explicitly asks.
- **Single source of truth:** `src/core_radio.html` (stations: the `streams` JSON in its script).
  Both apps ship it; never fork its logic into an app folder.
- **Tauri:** the `tauri` crate (`build__tauri_app/src-tauri/Cargo.toml`) and `@tauri-apps/cli`
  (`build__tauri_app/package.json`) stay on the same major. Rust toolchain:
  `build__tauri_app/src-tauri/rust-toolchain.toml`; Node: `mise.toml`.
- **Electron:** the sandboxed preload (`build__electron_app/javascript_preload.js`) may only
  `require("electron")`.
- **After a dependency change:** `just test-after-deps-update` (root `justfile`) must pass.
- **3+ step tasks:** write a `0-PLAN--<yyyy.mm.dd-hh.mm>--<task>.md` before coding.

## Layout

- `src/`: the web app (`core_radio.html`, `lib/`). Tauri serves it directly (`frontendDist: ../src`).
- `build__electron_app/`: `main.js`, preload, `script_prepare_static_html_for_electron_app.sh`
  (copies + processes the HTML), own `justfile` (`just start`, `just build-*`).
- `build__tauri_app/`: `src-tauri/` (Rust, `tauri.conf.json`, `capabilities/`), `scripts/`
  (Linux dev-env bootstrap: root `just bootstrap` / `just bootstrap-check`), own `justfile`.
- `build__scrape_loaded_html_page/`: headless-Chromium snapshot of the rendered page.
- `docs/` curated station list, screenshot · `docs_DEV/` developer notes. The web app / PWA (Radio Nerds) lives in `../RadioNerds`.
