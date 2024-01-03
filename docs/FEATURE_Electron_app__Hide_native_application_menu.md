# FEATURE: Electron app : Hide native application menu

RESEARCH from "Bing Copilot":

----
Yes, you can specify the menu options in the `main.js` file for your Electron app. Here's an example of how you can do it:

```javascript
const { app, BrowserWindow, Menu } = require('electron')

app.on('ready', () => {
  const mainWindow = new BrowserWindow({
    // Other window options...
  })

  // Hide the menu
  mainWindow.setMenuBarVisibility(false)

  // Load your HTML file into the window
  mainWindow.loadFile('yourfile.html')
})
```

In this example, `setMenuBarVisibility(false)` hides the menu bar. If you want the menu bar to auto-hide and show up when the `Alt` key is pressed, you can use `autoHideMenuBar: true` instead⁴.

Please note that these settings are for the Electron part of your application. Electron-Builder is a complete solution to package and build a ready-for-distribution Electron app, and it doesn't directly handle aspects like the application menu¹. It's the Electron framework that provides APIs to customize the application's menu².

Remember to replace `'yourfile.html'` with the path to your actual HTML file. Also, ensure that all your CSS and JavaScript are correctly included in your HTML file. If you have any other questions or need further clarification, feel free to ask! 😊

Source: Conversation with Bing, 03/01/2024
(1) Creating a custom menu bar in Electron - DEV Community. https://dev.to/saisandeepvaddi/creating-a-custom-menu-bar-in-electron-1pi3.
(2) Common Configuration - electron-builder. https://www.electron.build/configuration/configuration.html.
(3) Menu | Electron. https://www.electronjs.org/docs/latest/api/menu.
(4) Electron - Showing Menu on only Main Window - Stack Overflow. https://stackoverflow.com/questions/44589328/electron-showing-menu-on-only-main-window.


----
Yes, you can hide the Windows style menu in an Electron app. Here are a few methods you can use:

1. **Set Menu to Null**: You can use `win.setMenu(null)` on your window¹. However, this method might not work in some versions of Electron¹.

2. **Remove Menu**: Electron has `win.removeMenu()` (added in v5.0.0) to remove application menus instead of using `win.setMenu(null)`¹. But there seems to be a bug in Electron 7.1.x where `win.removeMenu()` doesn't work¹.

3. **Set Application Menu to Null**: The workaround for the above bug is to use `Menu.setApplicationMenu(null)`. However, this will disable all the menu shortcuts like F11 for toggling fullscreen, etc¹.

4. **Auto Hide Menu Bar**: In newer versions of Electron, you can set `autoHideMenuBar: true` while creating `browserWindow`. Pressing `Alt` will show the menu bar again¹⁴.

5. **Set Menu Bar Visibility**: You can use `mainWindow.setMenuBarVisibility(false)`¹.

Here's an example of how to use `autoHideMenuBar`:

```javascript
const mainWindow = new BrowserWindow({
  autoHideMenuBar: true,
});
```

Please note that the effectiveness of these methods may vary depending on the Electron version you are using¹..

Source: Conversation with Bing, 03/01/2024
(1) node.js - Remove menubar from Electron app - Stack Overflow. https://stackoverflow.com/questions/39091964/remove-menubar-from-electron-app.
(2) Electron Hide Menu Bar With Code Examples - folkstalk.com. https://www.folkstalk.com/2022/09/electron-hide-menu-bar-with-code-examples.html.
(3) Window Customization | Electron. https://www.electronjs.org/docs/latest/tutorial/window-customization.
(4) How to customize the window title bar of an Electron app?. https://stackoverflow.com/questions/35660043/how-to-customize-the-window-title-bar-of-an-electron-app.
(5) How to hide Electron.js menubar - Stack Overflow. https://stackoverflow.com/questions/54993545/how-to-hide-electron-js-menubar.
(6) undefined. https://github.com/electron/electron/issues/1415.
(7) en.wikipedia.org. https://en.wikipedia.org/wiki/Electron_(software_framework).
