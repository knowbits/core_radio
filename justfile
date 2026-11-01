# Set up a Linux dev host for the Tauri desktop app: system libraries (sudo), Rust, Node, npm deps.
# Idempotent -- safe to re-run.
bootstrap:
    build__tauri_app/scripts/bootstrap-linux-dev-env.sh

# Report what the dev env is missing; changes nothing.
bootstrap-check:
    build__tauri_app/scripts/bootstrap-linux-dev-env.sh --check

# Build the project
build:
    echo "Building project..."
    # Add your build commands here

# Clean the project
clean:
    echo "Cleaning project..."
    # Add your clean commands here

    

# ── test-after-deps-update ── used by COMMON/scripts/deps-update-all-repos.sh ── DO NOT DELETE ──
# The dependency updater (`deps-update-all-repos.sh --update --test-and-verify`, or the DEV_REPOS
# wrapper script--git--update-outdated-dependencies-in-all-local-repos.sh) runs this recipe in
# every repo it has just updated, to prove the repo still works with the new dependency versions.
# Arguments: one `<ecosystem>:<dir>` per updated part (e.g. `uv:.` `cargo:src-tauri`) so the
# recipe can run only the affected suites; no arguments = this repo's fast suite. Keep it fast
# (minutes, not the full CI); exit non-zero on failure. An empty body is reported by the updater
# as "empty recipe -- nothing tested" -- fill it in once the repo has a fast test gate.
[doc("Fast tests after a dependency update -- run by COMMON/scripts/deps-update-all-repos.sh")]
test-after-deps-update *CHANGED:
    #!/usr/bin/env bash
    # Per changed part: Tauri (cargo:..., npm:build__tauri_app) = locked build + 10 s headless
    # start; Electron (npm:build__electron_app) = headless start, station buttons rendered
    # (scripts/smoke-electron.mjs; add --play by hand to also prove a stream plays, needs network).
    set -euo pipefail
    changed="{{CHANGED}}"
    [ -n "$changed" ] || changed="cargo:build__tauri_app/src-tauri npm:build__electron_app"
    x=(); [ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ] || x=(xvfb-run -a)
    tauri=0 electron=0
    for part in $changed; do
        case "$part" in
        cargo:* | npm:build__tauri_app) tauri=1 ;;
        npm:build__electron_app) electron=1 ;;
        esac
    done
    if ((tauri)); then
        echo "== Tauri: cargo build --locked + headless start"
        (cd build__tauri_app/src-tauri && cargo build --locked --quiet)
        rc=0; timeout 10 "${x[@]}" build__tauri_app/src-tauri/target/debug/core-radio >/dev/null 2>&1 || rc=$?
        [ "$rc" -eq 124 ] || { echo "FAIL: Tauri app exited ($rc) before 10 s"; exit 1; }
        echo "ok: Tauri app still running after 10 s"
    fi
    if ((electron)); then
        echo "== Electron: headless start"
        "${x[@]}" node scripts/smoke-electron.mjs 2>/dev/null
    fi
