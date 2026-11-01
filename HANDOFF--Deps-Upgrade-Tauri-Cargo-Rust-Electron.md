# HANDOFF -- Make core_radio work on the latest Tauri, Cargo/Rust crates and Electron

Created 2026-11-01. Paste this file as the prompt for a fresh AI session started in
`~/DEV_REPOS/core_radio`. Follow `COMMON/AGENTS_COMMON.md` (Git Safety: no git writes).

## Goal

Every outdated dependency in core_radio is on its latest release (majors included), and
the Tauri app and the Electron app both still build and run. Undo an upgrade only when its
migration is not feasible, and say why with evidence.

## State at handover (all committed and pushed, 2026-11-01)

- `COMMON/scripts/deps-update-all-repos.sh --update --force --test-and-verify core_radio`
  ran. It fixed all 8 open GitHub security alerts (npm lockfiles) and took:
  - `build__electron_app`: electron 44.9.3 → **45.0.0** (major), electron-builder
    26.15.3 → 26.18.0, eslint 10.12.0 → 10.13.0
  - `build__tauri_app`: @tauri-apps/cli 2.12.2 → 2.12.4
- **The cargo step in `build__tauri_app/src-tauri` FAILED and was restored**, so none of
  the Rust crate updates (tauri, wry, wasm-bindgen family, etc.) were applied.
- `just test-after-deps-update` in the root `justfile` is empty (`# no fast tests yet`),
  so **nothing proved either app works** after the update. Only an Electron smoke check
  was done: `npm run pack` in `build__electron_app` succeeded on Electron 45.
- The status report still shows a large number of outdated / major deps for core_radio
  (184 outdated, 124 major before this run). Re-measure first (step 1).

## Known problems to solve

1. **Cargo update fails under the release cooldown.**
   Log (from the run): after `cargo upgrade --incompatible` + `cargo update`, the updater
   tried to move a too-new crate back:
   ```text
   $ cargo update -p js-sys@0.3.107 --precise 0.3.106
   error: failed to select a version for the requirement `js-sys = "=0.3.107"`
   required by package `wasm-bindgen-futures v0.4.80`
     ... reqwest v0.13.5 ... tauri v2.12.5 ... core-radio v0.1.2
   ```
   Cause: `wasm-bindgen-futures 0.4.80` pins `js-sys` exactly (`=0.3.107`), so the
   wasm-bindgen family (wasm-bindgen, -macro, -macro-support, -shared, -futures, js-sys,
   web-sys) can only move together. The cooldown downgrade in
   `COMMON/scripts/deps-update-all-repos.sh` moves one crate at a time.
   Decide and implement the right fix:
   - preferred: teach the updater's cargo cooldown step to downgrade an exact-pinned
     family together (or step the dependent back too), with a test in
     `COMMON/scripts/tests/test_deps_update_all_repos.py`; or
   - wait until js-sys 0.3.107 is ≥7 days old and re-run; or
   - one-off: run the update with `--cooldown 0` for core_radio only (needs the
     developer's OK: it takes releases younger than 7 days).
2. **Tauri / Rust crates to latest.** After cargo succeeds, build and run the Tauri app
   (`build__tauri_app`; see `0-PLAN--2026.10.17-08.39--Tauri-1-to-2-Migration*.md` and
   `0-PLAN--2026.10.17-09.26--Tauri-App-Plays-Core-Radio*.md` for how it is built and what
   "works" means). Read the release notes of every major/minor Tauri, wry, tao and
   plugin bump and migrate code/config (`tauri.conf.json`, capabilities) as required.
   Keep `tauri` (crate) and `@tauri-apps/cli` (npm) on the same major (the hold register
   `COMMON/scripts/deps-update-holds.txt` has a `link` rule for this). Rust toolchain:
   `build__tauri_app/src-tauri/rust-toolchain.toml` (stable).
3. **Electron 45 follow-ups** (`build__electron_app`). Checked so far: the app uses only
   stable APIs, the sandboxed preload only `require("electron")`, so the preload breaking
   change does not apply. Still open:
   - Electron 45 dropped 32-bit builds (Windows ia32, Linux armv7l). The package.json
     scripts `dist-linux-Intel-ia32`, `dist-windows-ia32`, `dist-linux-ARM` and the
     `--arch=all` variants will now fail: remove or fix them, and update any README text.
   - Launch the app and verify it plays the stream (not just packs).
   - Release notes: `gh release view v45.0.0 -R electron/electron`.
4. **No regression proof.** Fill the root `justfile` recipe `test-after-deps-update`
   with a real fast check for both apps (e.g. `cargo check`/`cargo test` in
   `build__tauri_app/src-tauri`, a headless Electron start or `npm run pack`), so the
   updater can prove future updates. Keep the recipe's header comment.

## Steps

1. `~/DEV_REPOS/COMMON/scripts/deps-update-all-repos.sh ~/DEV_REPOS/core_radio`
   (report mode, changes nothing): the full outdated list per ecosystem/dir.
2. Fix problem 1, then
   `~/DEV_REPOS/COMMON/scripts/deps-update-all-repos.sh --update --test-and-verify ~/DEV_REPOS/core_radio`
   (the repo is clean now, so no `--force`).
3. Migrate code for each major (problems 2 and 3); build and run both apps.
4. Problem 4: real `test-after-deps-update`; re-run step 2 until the SUMMARY has no
   NEEDS YOUR ACTION and no CHECK BY HAND for core_radio.
5. Report: what was upgraded, what code changed and why, anything left on an older
   version with the reason. Do not commit; the developer does the git work.
