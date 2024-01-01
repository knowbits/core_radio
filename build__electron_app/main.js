const electron = require('electron');
const path = require('path');
const { app, BrowserWindow } = electron;

let mainWindow;

app.on('ready', () => {
  mainWindow = new BrowserWindow({
    width: 270,
    height: 550
  });

  mainWindow.setTitle('Streaming Radio Player');
  // NOTE: "__dirname" is a Node.js global variable that gets the directory name of the current module
  mainWindow.loadFile(path.join(__dirname, 'index.html'));

  mainWindow.on('closed', () => {
    mainWindow = null;
  });
});
