#!/usr/bin/env node
// Headless smoke test of the Electron app: start it with a DevTools port, check the station
// buttons rendered, and (with --play) click the first station and wait until its <audio>
// currentTime advances, i.e. the stream really plays (needs network).
// Usage: xvfb-run -a node scripts/smoke-electron.mjs [--play]   (exit 0 = pass)
import { spawn } from "node:child_process";
import { setTimeout as sleep } from "node:timers/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const appDir = path.join(path.dirname(fileURLToPath(import.meta.url)), "..", "build__electron_app");
const play = process.argv.includes("--play");
const port = 9300 + Math.floor(Math.random() * 600);
const electron = path.join(appDir, "node_modules", ".bin", "electron");

const child = spawn(
  electron,
  [".", `--remote-debugging-port=${port}`, "--autoplay-policy=no-user-gesture-required", "--no-sandbox"],
  { cwd: appDir, stdio: ["ignore", "inherit", "inherit"] },
);
let exited = false;
child.on("exit", (code) => { exited = true; if (code) console.error(`electron exited early: ${code}`); });

const fail = (msg) => { console.error(`FAIL: ${msg}`); child.kill(); process.exit(1); };

async function pageSocket() {
  for (let i = 0; i < 60 && !exited; i++) {
    try {
      const list = await (await fetch(`http://127.0.0.1:${port}/json/list`)).json();
      const page = list.find((t) => t.type === "page" && t.url.endsWith(".html"));
      if (page) return page.webSocketDebuggerUrl;
    } catch { /* not up yet */ }
    await sleep(500);
  }
  return null;
}

const wsUrl = await pageSocket();
if (!wsUrl) fail("no page target (app did not start)");
const ws = new WebSocket(wsUrl);
await new Promise((ok, ko) => { ws.onopen = ok; ws.onerror = ko; });
let id = 0;
const pending = new Map();
ws.onmessage = (m) => { const r = JSON.parse(m.data); pending.get(r.id)?.(r); };
const evaluate = (expression) => new Promise((ok) => {
  pending.set(++id, (r) => ok(r.result?.result?.value));
  ws.send(JSON.stringify({ id, method: "Runtime.evaluate", params: { expression, returnByValue: true } }));
});

let buttons = 0;
for (let i = 0; i < 40 && !buttons; i++) {
  buttons = await evaluate('document.querySelectorAll("#radioSections button").length');
  if (!buttons) await sleep(250);
}
if (!buttons) fail("no station buttons rendered");
console.log(`ok: Electron ${await evaluate("navigator.userAgent.match(/Electron\\/[\\d.]+/)?.[0]")} rendered ${buttons} station buttons`);

if (play) {
  const title = await evaluate('(b => (b.click(), b.textContent))(document.querySelector("#radioSections button"))');
  let t = 0;
  for (let i = 0; i < 60 && t <= 1; i++) {
    await sleep(500);
    t = await evaluate('document.querySelector("#radioSections audio").currentTime');
  }
  const err = await evaluate('document.querySelector("#radioSections audio").error?.code ?? null');
  if (t <= 1) fail(`stream "${title}" did not play (currentTime ${t}, media error ${err})`);
  console.log(`ok: stream "${title}" plays (currentTime ${t.toFixed(1)} s)`);
}
ws.close();
child.kill();
process.exit(0);
