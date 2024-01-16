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
 * Electron"s "main process" has some issues with "ES modules" (ESM)
 * => It is recommended to use "CommonJS" modules.
 */
const path = require("path");
const { app, ipcMain, BrowserWindow } = require("electron");

let webPageWindow;

/*
 * The "BrowserWindow" class is used to create and control browser windows ("renderer processes").
 * Each browser window displays a web page (HTML page).
 */
function createWebPageWindow() {

  webPageWindow = new BrowserWindow({
    webPreferences: {
      // The "preload" property is used to run scripts before the "main window"s" scripts.
      // The "preload.js" script runs with full "Node.js" access rights,
      // even if the "nodeIntegration" property is set to false.
      preload: path.join(__dirname, "preload.js"),

      // NOTE: "nodeIntegration" is disabled by default in "Electron 12".
      // "true": Enable to use Node.js modules in the HTML document.
      // "false": Prevent the renderer processes (the web pages) from accessing Node.js APIs.
      nodeIntegration: false,

      // This option isolates the JavaScript contexts, preventing the
      // preload script from accessing the Electron APIs in the renderer process directly.
      // Instead, you have to use the contextBridge module to expose specific APIs
      // to the renderer process in a safe manner.
      //
      // This is a security feature that helps prevent potential attacks from malicious scripts.
      contextIsolation: true,

      // The "webSecurity" option allows you to control whether to enable the same-origin policy.
      // Ensures that the return values of "executeJavaScript" are serialized safely.
      // When it's set to true, Electron will ensure that the serialization of the
      // executeJavaScript method is compatible with the serialization used in the
      // contextBridge module.
      // This is a recommended setting when using "contextIsolation: true".
      worldSafeExecuteJavaScript: true,

      // This option enables a Chromium feature that limits the power and scope
      // of the renderer process. When this option is enabled, the renderer process runs
      // in a separate OS-level process and has a more limited access to Electron APIs.
      // This is another security feature that helps mitigate potential security risks.
      sandbox: true,

      // The "remote" module provides a simple way to do inter-process communication (IPC)
      // between the renderer and the main process in Electron. However, it's been deprecated
      // due to security concerns. When enableRemoteModule is set to false, the "remote" module
      // is disabled. This is a recommended security setting.
      enableRemoteModule: false,
    },

    width: 400,
    height: 450,

    // Hide / Show the "native" menu bar by pressing the `Alt` key:
    autoHideMenuBar: true,

    // NOTE: This allows you to implement your own custom window controls.
    // Set the background color of the window:
    // NOTE: Should be the same as the background color of the HTML document and the CSS body element:
    backgroundColor: "#262626",

    // Create a frameless window (removes the default OS window frame):
    frame: false,
    // Make the window transparent: (NOTE: You can"t move the window around when it"s transparent)
    // This is needed to create a window with custom, non-standard borders. Or a non-standard window shape.
    transparent: true
  });

  webPageWindow.setTitle("Core Radio");

  // Use Error Handling when loading the "web page" file
  // NOTE: "__dirname" is a Node.js global variable that gets
  //       the directory name of the current module
  webPageWindow.loadFile(path.join(__dirname, "core_radio__processed_for_electron_app.html"))
    .catch(err => {
      console.error(`Failed to load file: ${err}`);
    });


  // Emitted when the window is closed.
  webPageWindow.on("closed", () => {
    webPageWindow = null;
  });

  // DEBUG: Uncomment to open the "Chrome developer tools" when your app starts.
  //        => Inspect your HTML, CSS, and JavaScript, and see errors / logs in the "console".
  //
  // mainWindow.webContents.openDevTools();

} // END: "createWindow()"

// Single Instance Lock
const gotTheLock = app.requestSingleInstanceLock();

if (!gotTheLock) {
  // Another instance of the app is already running, quit this instance.
  app.quit();
} else {
  // No other instance is running, continue with this instance.

  // The "second-instance" event is emitted when a "second instance" of the app is executed.
  app.on("second-instance", (_event, _commandLine, _workingDirectory) => {
    // Someone tried to run a second instance => focus the window of the first instance:
    if (webPageWindow) {
      if (webPageWindow.isMinimized()) webPageWindow.restore();
      webPageWindow.focus();
    }
  });

  // Disable GPU hardware acceleration (caused problems on Ubuntu (WLS2))
  // NOTE: This must be called before the "app" module's "ready" event is emitted.
  app.disableHardwareAcceleration();

  // Create "mainWindow" (the "renderer process" that displays the HTML document)
  // when Electron has finished initializing and is ready to create browser windows.
  app.whenReady().then(() => {
    // Create the "web page window" (the "renderer process" that displays the HTML document)
    createWebPageWindow();
    setAppSettingsAndHandlers();
    addListenersForFunctionsExposedToRendererProcesses();
  });

}; // END: "Single Instance Lock"

/*
  * ====================================================
  * Set up the "app" settings and handlers for the Electron app
  * ====================================================
  */
function setAppSettingsAndHandlers() {
  // app.setAppUserModelId("com.core.radio");
  // app.setAsDefaultProtocolClient("core-radio");

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
  //
  // Instead of using the "system locale", we set a specific locale ("en-US") for the Electron app:
  //
  // TODO: Was commented out, due to locale-related error when building on MacOS.
  // TODO: Se comment in script: "./scripts/remove-locales.js"
  //
  // app.commandLine.appendSwitch("lang", "en-US");

  /*
   * NOTE: The "activate" event is emitted when the user clicks on the app"s dock icon (OS X)
   *       and there are no other windows open. Typically, apps re-create a window in this case.
   */
  app.on("activate", function () {
    // if (BrowserWindow.getAllWindows().length === 0) { createWindow() }
    if (webPageWindow === null) { createWebPageWindow(); }
  });

  /*
   * Quit when all windows are closed, except on macOS. There, it"s common for
   * applications and their menu bar to stay active until the user quits
   * explicitly with Cmd + Q.
   *
   * Config required in ".eslintrc" for "eslint" to recognise the "process" global variable:
   *   "env": { "node": true }
  */
  app.on("window-all-closed", function () {
    if (process.platform !== "darwin") {
      app.quit();
    }
  });

}; // END: "setAppSettings()"

/*
  * ====================================================
  * Add listeners for functions exposed to "renderer processes"
  * ====================================================
  */
function addListenersForFunctionsExposedToRendererProcesses() {
  /*
 * The "ipcMain" module is an instance of the EventEmitter class.
 * When used in the "main process", it handles asynchronous
 * and synchronous messages sent from a "renderer process" (web page).
 */
  ipcMain.on("close-app", (event, _arg) => {
    let win = event.sender.getOwnerBrowserWindow();
    win.close();
    // mainWindow.close();
  });

  ipcMain.on("open-dev-tools", (event, _arg) => {
    let win = event.sender.getOwnerBrowserWindow();
    win.webContents.openDevTools();
    // mainWindow.webContents.openDevTools();
  });

} // END: "addListenersForFunctionsExposedToRendererProcesses()"
