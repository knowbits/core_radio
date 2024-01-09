/*
* This file is the "main process" of the Electron app.
 *
 * It is responsible for:
 *   Creating and managing the "renderer processes" (the web pages).
 *   Creating the "native" GUI elements of the Electron app.
 *   Communicating with the "renderer processes" via IPC.
 *   Communicating with the operating system via the Electron API.
 *   Communicating with the Node.js API.
 *
 * Concept inherited from Chromium: "main processes" and "renderer processes".
 *
 * The "main process" creates the "native" GUI elements of the Electron app:
 *
 *   Menus and menu bar, window controls (minimize, maximize, close, resize, move)
 *   Window: frame, shape, transparency, shadow animations.
 *   Shortcuts, tray icon (Windows, Linux), "Native" dock icon (OS X).
 *   Notifications, system dialogs, progress bar, file associations.
 *   File system access, clipboard access, screen capture, global shortcuts.
 *
 * System monitoring: power status, power saving settings, idle state, and general system metrics.
 * Process monitoring: metrics, memory information, CPU information, I/O count, heap statistics,
 *   handle count, uptime, resource usage, CPU usage, and memory usage.
 */

/*
 * ====================================================
 * Electron's "main process" has some issues with "ES modules" (ESM)
 * => It is recommended to use "CommonJS" modules.
 */
const path = require('path');
const { app, ipcMain, BrowserWindow } = require('electron');

/*
 * The "ipcMain" module is an instance of the EventEmitter class.
 * When used in the "main process", it handles asynchronous
 * and synchronous messages sent from a "renderer process" (web page).
 */

/*
 * Listen for a ‘close’ event by using Electron's "ipcMain" module
 */
ipcMain.on('close', () => {
  app.quit();
});

function createWindow() {

  let mainWindow = new BrowserWindow({
    webPreferences: {
      // The "preload" property is used to run scripts before the "main window's" scripts.
      // The "preload.js" script runs with full "Node.js" access rights,
      // even if the "nodeIntegration" property is set to false.
      preload: path.join(__dirname, 'preload.js'),

      // NOTE: "nodeIntegration" is disabled by default in "Electron 12".
      // "true": Enable to use Node.js modules in the HTML document.
      // "false": Prevent the renderer processes (the web pages) from accessing Node.js APIs.
      nodeIntegration: false
    },
    width: 400,
    height: 450,

    // Hide / Show the "native" menu bar by pressing the `Alt` key:
    autoHideMenuBar: true,

    // NOTE: This allows you to implement your own custom window controls.
    // Set the background color of the window:
    // NOTE: Should be the same as the background color of the HTML document and the CSS body element:
    backgroundColor: '#262626',

    // Create a frameless window (removes the default OS window frame):
    frame: false,
    // Make the window transparent: (NOTE: You can't move the window around when it's transparent)
    // This is needed to create a window with custom, non-standard borders. Or a non-standard window shape.
    transparent: true
  });

  mainWindow.setTitle('Core Radio');

  // NOTE: "__dirname" is a Node.js global variable that gets the directory name of the current module
  mainWindow.loadFile(path.join(__dirname, 'core_radio__static_html_processed.html'));

  mainWindow.on('closed', () => {
    mainWindow = null;
  });

  // DEBUG: Uncomment to open the "Chrome developer tools" when your app starts.
  //        => Inspect your HTML, CSS, and JavaScript, and see errors / logs in the "console".
  //
  // mainWindow.webContents.openDevTools();
}

// ====================================================
// GOAL: Reduce the size of the Electron app by excluding most locales (the ".pak" files).
//
// NOTE: By default, an Electron app automatically uses the system’s locale.
//       => The app will be localized to the system’s language (date, currency, spell checker).
//
// NOTE: To get the system’s locale in the "main process", call "app.getLocale()".
//
// About "locale" in Chromium:
// https://www.chromium.org/developers/design-documents/internationalization
//
// All target platforms of an Electron app, including Windows, macOS, and Linux,
// use ".pak" files for locales. The Electron framework leverages Chromium’s
// internationalization (i18n) infrastructure, which stores locale data in
// these ".pak" files. This ensures uniform handling of locale data across all platforms.
// The same approach is used to include or exclude certain ".pak" files for all platforms.

// Instead of using the "system locale", we set a specific locale ("en-US") for the Electron app:
app.commandLine.appendSwitch('lang', 'en-US');

app.whenReady().then(createWindow);

/* NOTE: The "window-all-closed" event is emitted when all windows have been closed.
 *  In OS X, it is common for applications and their menu bar to stay active until the user quits explicitly
 *  with Cmd + Q
 *
 * // TODO: NEEDED? USEFUL?
 *
app.on('window-all-closed', () => {

  if (process.platform !== 'darwin') {
    app.quit()
  }
})
*/

/*
 * NOTE: The "activate" event is emitted when the user clicks on the app's dock icon (OS X)
 * and there are no other windows open. Typically, apps re-create a window in this case.
 *
 * // TODO: NEEDED? USEFUL?
 *
app.on('activate', () => {

  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow()
  }
})
*/
