const electron = require('electron');
const path = require('path');
const { app, BrowserWindow } = electron;

function createWindow() {

  let mainWindow = new BrowserWindow({
    width: 290,
    height: 550,

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
  mainWindow.loadFile(path.join(__dirname, 'core_radio__copied_from_src.html'));

  mainWindow.on('closed', () => {
    mainWindow = null;
  });

  // DEBUG: Uncomment to open the "Chrome developer tools" when your app starts.
  //        => Inspect your HTML, CSS, and JavaScript, and see errors / logs in the "console".
  //
  // mainWindow.webContents.openDevTools();
}

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
