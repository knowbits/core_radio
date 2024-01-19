/*
 * Use a "preload script" to expose only the functionality you need to the renderer
 * process, while still protecting the rest of your application from malicious code.
 *
 * This is a recommended practice for Electron apps to maintain
 * security and isolation between "renderer processes" (web pages).
 */

const { contextBridge, ipcRenderer } = require("electron");

/**
 * Expose two functions: "closeApp" and "openDevTools" to the "renderer processes" (web pages).
 *
 * Both of these functions send a message to the "main process" using "ipcRenderer.send".
 * Make sure to liste for these messages in the "main process" (‘close-app’ and ‘open-dev-tools’).
 */
contextBridge.exposeInMainWorld(
  "api", {
  closeApp: function () {
    ipcRenderer.send("close-app");
  },
  openDevTools: function () {
    ipcRenderer.send("open-dev-tools");
  }
});
