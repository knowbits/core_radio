/*
 * Use a "preload script" to expose only the functionality you need to the renderer
 * process, while still protecting the rest of your application from malicious code.
 *
 * This is a recommended practice for Electron apps to maintain security and isolation between processes.
 */

window.closeApp = function () {
  const { remote } = require('electron');
  remote.getCurrentWindow().close();
}
