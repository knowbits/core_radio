/*
 * Use a "preload script" to expose only the functionality you need to the renderer
 * process, while still protecting the rest of your application from malicious code.
 *
 * This is a recommended practice for Electron apps to maintain security and isolation between processes.
 */


const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld(
  "api", {
  closeApp: function () {
    ipcRenderer.send('close-app');
  }
});
