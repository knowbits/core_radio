# How to build an Electron app from the static html file

Describes how to build an Electron app from the static html file `.src\radio_streams_player.html` that will run on Windows 11 64-bit.

These instructions only show build a binary exxecutable for the Windows 11 64-bit platform. Other target platforms, such as Linux and macOS, have not been tested yet, but should also work.

The build steps show how to build the "Electron app" on Ubuntu (tested on WSL2 on Windows). Other build platforms have not been tested yet, but should also work.

NOTE: All the instructions below assume that you are in the `<PROJECT_ROOT>/build__electron_app/` folder.

## Install Electron prerequisites: Node.js, npm, Ubuntu packages

### Install Node.js and npm

1. NOTE: Node.js and npm are required to build an Electron app as an executable binary for the target platforms.
2. Firs, update the Ubuntu package index: `sudo apt update`
3. Install by running: `sudo apt install nodejs npm`
4. Verify installation: `node -v` and `npm -v`

### Install Electron

1. Install Electron as a "development dependency" in your app:
  * Install "Electron": `npm install --save-dev electron@latest`
  * Will output `"added 75 packages in 32s"`
  * The follwoing files will be created:
    1. `package-lock.json`
    2. `node_modules/` folder:
       1. All the local node.js dependencies will be installed here.
    3. `package.json` file
       1. It will contain `electron` as a `"devDependencies":` entry.

2. PS! These files/folders should not be in git, so add them in your `../.gitignore` file.

3. Verify installation with one of these methods:
   1. ` ./node_modules/.bin/electron -v`
   2. `npx electron -v`
      1. NOTE: `npx` is a tool that comes with `npm` and allows you to run locally installed packages.
   3. Add a script to your `package.json` file:
      1. `"scripts": { "electron": "electron" }`
      2. Run: `npm run electron -v`

### Install the "Electron packager" package

1. The `electron-packager` is required to build an Electron app as an executable binary for misc. target platforms.
  * Install: `npm install --save-dev electron-packager`
  * Will output `"added 99 packages, ..."`
  * Adds `electron-packager` as a `"devDependencies":` entry in the `package.json` file.


2. NOTE: `electron-packager` is a tool that packages your Electron app into an executable for a target platform.
   1. An .exe file for Windows.
   2. A .dmg file for Linux.
   3. An .AppImage file for macOS.

3. TODO: NOTE: The `electron-packager` package is deprecated. Use `electron-forge` instead.
   1. `electron-forge` is a modern replacement for `electron-packager` and it's recommended for new projects. It provides a unified high-level API to scaffold, package and publish apps and is capable of producing executables for Windows, Linux, and Mac.
   2. However, if you have an existing project that uses `electron-packager` and it's working well, there's no urgent need to switch to `electron-forge`. While `electron-packager` is deprecated, it's still maintained and receives updates.

### Install required Ubuntu packages

1. Install Ubuntu packages required to build an Electron app as an executable binary for the Windows 64-bit platform:
   * TODO: NOTE: It has not yet been verified which of these packages are actually needed, or if more packages might be needed:
   * Install Ubuntu packages: `sudo apt-get install libgtkextra-dev libgconf2-dev libnss3 libasound2 libxtst-dev libxss1 libgtk-3-0`

## About "`main.js`": The entry point for an Electron app

2. NOTE: Electron package uses "main.js" as the default entry point to build an app.
    1. Location: `<PROJECT_ROOT>/build__electron_app/main.js`.
    2. The `main.js` specifies a "minimal Electron app":
       1. It creates a browser window and loads the `index.html` file.
    3. It is also required to build an "Electron app" as an executable binary for the target platforms.
    4. The `main.js` file itself is not required to run the Electron app, it is only required to build the Electron app.

## Create an executable binary for Windows 64-bit

1. Copy the "static html file" and the "favicon" to the Electron build folder:
   1. `cp ../src\radio_streams_player.html ./index.html`
   2. `cp ../icons/Elegantthemes-Beautiful-Flat-One-Color-Radio.ico ./favicon.ico`

3. To build the Electron app, run `npx electron-packager . radio_streams_player --platform=win32 --arch=x64  --icon=./favicon.ico --out=release-builds --overwrite`
   1. Creates the Electron app executable file:
   2. `./release-builds/radio_streams_player.exe` folder,

4. NOTE: The `--electron-version=13.1.7` parameter is optional. If not specified, the latest version of Electron will be used.

5. Copy folder with `radio_streams_player.exe` and all it's dependencies (DLLs etc) to your Windows Desktop:
   1. For example: `cp -r ./release-builds/radio_streams_player-win32-x64/ /mnt/c/Users/<Insert Your Windows user name here>/Desktop/`

6. Now you can run the Electron app by double-clicking the `radio_streams_player.exe` file in the `radio_streams_player-win32-x64/` folder on your Windows Desktop.

## Run the "Electron app" from the command line (no executable binary required)

1. Run the Electron app from the command line: `./node_modules/.bin/electron .` or `npx electron .`

## Create a Windows installer using `electron-builder`

> NOTE: `electron-builder` is a tool that packages your Electron app into an executable for a target platform.
> * An .exe file for Windows.
> * A .dmg file for Linux.
> * An .AppImage file for macOS.

> It is a complete solution to package and build a ready for distribution Electron app for macOS, Windows and Linux with “auto update” support out of the box.

1. Prerequisites: `npm install --save-dev electron-builder`
  1. Adds `electron-builder` as a `"devDependencies":` entry in the `package.json` file.
  2. Will output `"added 148 packages, ..."`

2. Make sure that package.json looks something like this:
    ```
    {
      "name": "streaming-radio-player",
      "version": "0.1.0",
      "description": "Streaming Radio Player",
      "author": "Erlend Bleken <bleken@gmail.com>",
      "license": "MIT",

      "main": "main.js",
      "build": {
        "appId": "org.bleken.streamingRadioPlayer",
        "win": {
          "target": [
            {
              "target": "nsis",
              "arch": [
                "x64"
              ]
            }
          ],
          "icon": "favicon_256x256.ico"
        },
        "nsis": {
          "oneClick": false,
          "allowToChangeInstallationDirectory": true
        }
      },
      "scripts": {
        "start": "electron .",
        "pack": "electron-builder --dir",
        "dist": "electron-builder --windows --x64"
      },
      "devDependencies": {
        "electron": "^28.1.0",
        "electron-builder": "^24.9.1",
        "electron-packager": "^17.1.2"
      }
    }
    ```

* Options explained:
   * `"dist": "electron-builder --windows --x64"`
     * If you’re running the `npm run dist`` command on a non-Windows platform (like macOS or Linux), `electron-builder` will by default only build the installer for the current platform.
     * To build the installer for Windows on a non-Windows platform (like Ubuntu on WSL2), you need to specify the `--windows` and `--x64` flags like we have done.
   * `appId`: The appId in Electron is a unique identifier used by the OS to consistently recognize your app across different versions.
   * `"target": "nsis"`:
     * The "nsis" target uses the _"Nullsoft Scriptable Install System (NSIS)"_ to create a customizable Windows installer for your Electron app.
     * "NSIS" allows for options like one-click or assisted install, directory selection, silent installs, and automatic updates.
     * NOTE: More "targets" can be specified such as: "zip", "7z", "msi", "nsis-web", "portable", "appx", "squirrel", "deb", "rpm", "freebsd", "pacman", "p5p", "apk", "dmg", "mas", "mas-dev", "pkg", "tar.gz", "tar.xz", "tar.lz", "tar.bz2", "dir", "custom".
   * `"arch": [ "x64" ]`: To create an installer for Windows 64-bit only.
   * `"icon": "favicon.ico"`: The icon to use for the installer.
   * `"oneClick": false`: To create an assisted installer.
   * `"allowToChangeInstallationDirectory": true`: Allow the user to change the installation directory.

1. To create an "NSIS" installer for the Windows 64-bit platform, run: `npm run dist`
   1. Creates the installer (.exe) here: `./dist/streaming-radio-player Setup 0.1.0.exe`.

2. To copy the installer to your Windows Desktop, run: `cp "./dist/streaming-radio-player Setup 0.1.0.exe" /mnt/c/Users/<Insert Your Windows user name here>/Desktop/`

## NOT TESTED: Create executable binaries for Linux or MacOS

It should be as easy as removing the two options `--windows --x64` from the `"scripts" > "dist"` section of `package.json`, and then running `npm run dist` again.

* _NOTE: The following commands have not been tested yet, but should work._

* Build an executable file for Linux: `electron-packager . --platform=linux`

* Build an executable file for macOS: `electron-packager . --platform=darwin`

* Build an executable file for all platforms: `electron-packager . --all`

## USEFUL: Electron app development resources

* VIDEO: "[How to BUILD a DESKTOP app with HTML, CSS & JavaScript using Electron JS!](https://www.youtube.com/watch?v=TkAiVKfWtjI)" on YouTube.

* "[Electron Documentation](https://www.electronjs.org/docs)".

* "[Electron Quick Start](https://www.electronjs.org/docs/tutorial/quick-start)".

* "[Electron API Demos](https://www.electronjs.org/#get-started)".

* "[Electron Fiddle](https://www.electronjs.org/fiddle)".
  * Electron Fiddle lets you create and play with small Electron experiments.
  * Quick-start template. Choose Electron version. Play around.

* "[Electron Forge](https://www.electronforge.io/)".
  * Electron Forge is a batteries-included toolkit for building, publishing and installing Electron apps.
  * Electron Forge unifies the existing (and well maintained) build tools for Electron development into a simple, easy to use package so that anyone can jump right in to Electron development.
