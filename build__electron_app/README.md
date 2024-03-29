# How to build an Electron app from the static html file

// TODO: Consider using the "web scraped" version of the static html file =>
// TODO: => The scraped HTML shows the generated "innerHTML" that is created by
// TODO:    by Javascript when the page loads in the browser.
// TODO:  BENEFITS: 1) User can see the generated HTML using "View source" : audio, button etc.
// TODO:            2) The scraped page might be faster (load), since there is minimal Javascript to run.

Describes how to build an Electron app from the static html file `.src\core_radio.html` that will run on Windows 11 64-bit.

These instructions only show build a binary exxecutable for the Windows 11 64-bit platform. Other target platforms, such as Linux and macOS, have not been tested yet, but should also work.

The build steps show how to build the "Electron app" on Ubuntu (tested on WSL2 on Windows). Other build platforms have not been tested yet, but should also work.

NOTE: All the instructions below assume that you are in the `<PROJECT_ROOT>/build__electron_app/` folder.

## Install Electron prerequisites: Node.js, npm, Ubuntu packages

### Install Node.js and npm

1. NOTE: Node.js and npm are required to build an Electron app as an executable binary for the target platforms.
2. Firs, update the Ubuntu package index: `sudo apt update`
3. Install by running: `sudo apt install nodejs npm`
4. Verify installation: `node -v` and `npm -v`

However, this might not install the latest version of `nodejs`and `npm`, so we need to install `nvm` to achieve that:

1. Install `nvm` - the "Node Version Manager":

   * `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash`
      * Restart the terminal to set `export NVM_DIR="$HOME/.nvm"` in the `~/.bashrc` file.
      * Verify that `nvm` is installed by running `nvm --version`.

2. Now, use `nvm` to install the latest version of `nodejs` and `npm`:

   * `nvm install node` # Will install the latest version of both `nodejs` and `npm`.
   * Verify installation: `node -v` and `npm -v`
   * Switch to the latest version of `nodejs` and `npm` by running: `nvm use node`
   * Switch to a specific version of `nodejs` and `npm` by running: `nvm use 14.17.6`

3. Update `npm` to the latest version:

   * `npm install npm@latest -g`
   * Verify installation: `npm -v`

### Install the `npm` dependencies defined in `package.json` locally

1. Run: `npm install`

   * The dependencies will be placed in the `./node_modules/` folder.
   * List all the packages that weere installed by running: `npm list --depth=0`

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
   1. `./node_modules/.bin/electron -v`
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

## About "`package.json`": Build configuration for 'electron-builder'

* The `package.json` file is required to build an Electron app as an executable binary for the target platforms.
* It is also required to run the "Electron app" locally for testing purposes.
* The `package.json` file is located here: `<PROJECT_ROOT>/build__electron_app/package.json`.
* The `package.json` file contains the build configuration for the `electron-builder` tool.

* Explaining config: `"postinstall": "electron-builder install-app-deps",`
  * This will install the required 'Node.js' dependencies (if any) for the target platform.
  * This is required to build an Electron app as an executable binary for the target platforms.

> The `postinstall` script in a `package.json` file is a hook that is automatically executed by npm (Node Package Manager) after the package (as defined in `package.json`) is installed. The `postinstall` script is executed after all the dependencies listed in the `package.json` file are installed.

> The `install-app-deps` command will install any app dependencies, e.g. native `Node.js` addons, that need to be rebuilt to be compatible with the version of Electron being used.

## Create an executable binary for Windows 64-bit

1. Copy the "static html file" to the Electron build folder
   * `cp ../src\core_radio.html ./index.html`

2. Convert the .ico file to a "256x256" .ico file using ImageMagick: Save to the Electron build folder

   * `convert ../icons/Elegantthemes-Beautiful-Flat-One-Color-Radio.ico -resize 256x256 ./icons/favicon_256x256.ico`

3. To build the Electron app, run `npx electron-packager . core_radio --platform=win32 --arch=x64  --icon=./icons/favicon_256x256.ico --out=release-builds --overwrite`
   1. Creates the Electron app executable file:
   2. `./release-builds/core_radio.exe` folder,

4. NOTE: The `--electron-version=13.1.7` parameter is optional. If not specified, the latest version of Electron will be used.

5. Copy folder with `core_radio.exe` and all it's dependencies (DLLs etc) to your Windows Desktop:
   1. For example: `cp -r ./release-builds/core_radio-win32-x64/ /mnt/c/Users/<Insert Your Windows user name here>/Desktop/`

6. Now you can run the Electron app by double-clicking the `core_radio.exe` file in the `core_radio-win32-x64/` folder on your Windows Desktop.

## Run the "Electron app" from the command line (no executable binary required)

1. Run the Electron app from the command line: `./node_modules/.bin/electron .` or `npx electron .`

## Create a Windows installer using `electron-builder`

> NOTE: `electron-builder` is a tool that packages your Electron app into an executable for a target platform.
>
> * An .exe file for Windows.
> * A .dmg file for Linux.
> * An .AppImage file for macOS.

> It is a complete solution to package and build a ready for distribution Electron app for macOS, Windows and Linux with “auto update” support out of the box.

### Prerequisites

* The `electron-builder` tool needs `wine` to create Windows installers on non-Windows platforms, like Ubuntu.
  * Firs, update the Ubuntu package index: `sudo apt update`
  * Install `wine` on Ubuntu: `sudo apt-get install --install-recommends wine-stable`
  * Verify installation: `wine --version`

* Install the `electron-builder` npm package:
  * Run `npm install --save-dev electron-builder`
    1. Adds `electron-builder` as a `"devDependencies":` entry in the `package.json` file.
    2. Will output `"added 148 packages, ..."`

1. Make sure that `package.json` is configured like this: [package.json](./package.json):

* Misc. `package.json` options explained (JSON does not allow comments):
  * `"dist-windows-x64": "electron-builder --windows --x64"`
    * If you’re running the `npm run dist`` command on a non-Windows platform (like macOS or Linux),`electron-builder` will by default only build the installer for the current platform.
    * To build the installer for Windows on a non-Windows platform (like Ubuntu on WSL2), you need to specify the `--windows` and `--x64` flags like we have done.
  * `appId`: The appId in Electron is a unique identifier used by the OS to consistently recognize your app across different versions.
  * `"target": "nsis"`:
    * The "nsis" target uses the _"Nullsoft Scriptable Install System (NSIS)"_ to create a customizable Windows installer for your Electron app.
    * "NSIS" allows for options like one-click or assisted install, directory selection, silent installs, and automatic updates.
    * NOTE: More "targets" can be specified such as: "zip", "7z", "msi", "nsis-web", "portable", "appx", "squirrel", "deb", "rpm", "freebsd", "pacman", "p5p", "apk", "dmg", "mas", "mas-dev", "pkg", "tar.gz", "tar.xz", "tar.lz", "tar.bz2", "dir", "custom".
  * `"arch": [ "x64" ]`: To create an installer for Windows 64-bit only.
  * `"icon": "favicon_256x256.ico"`: The icon to use for the installer.
  * `"oneClick": false`: To create an assisted installer.
  * `"allowToChangeInstallationDirectory": true`: Allow the user to change the installation directory.

1. To create an "NSIS" installer for the Windows 64-bit platform, run: `npm run dist`
   1. Creates the installer (.exe) here: `./dist/streaming-radio-player Setup 0.1.0.exe`.

2. To copy the installer to your Windows Desktop, run: `cp "./dist/streaming-radio-player Setup 0.1.0.exe" /mnt/c/Users/<Insert Your Windows user name here>/Desktop/`

## NOT TESTED: Create executable binaries for MacOS

> Unfortunately, you cannot build a .pkg or .dmg macOS installer on Ubuntu or WSL2 using electron-builder

> Use a different target: If the above options are not feasible, consider using a different target that doesn’t require macOS-specific tools. For example, you could use `zip` or `dir` as your target.
>
> The `zip` target will create a zip file that you can distribute to macOS users.
> The `dir` target will create a folder that you can distribute to macOS users.

> Both of these targets can be created on non-macOS platforms.
> However, they will not be signed or notarized, so macOS users will need to disable Gatekeeper to run them.

> To install a "zip" or "dir" target on macOS, the user will need to unzip the file and then move the app to the Applications folder.

* To build a macOS `zip` target on Ubuntu, run: `npm run dist -- --mac --x64` add this to `package.json`:

  ```json
  "build": {
    "mac": {
      "target": "zip"
    }
  }
  ```

Then run one of these commands for creating executable binaries for MacOS on the Intel or Apple silicone platforms:

* For "Mac silicon": `npx electron-builder --mac --arm64`
* For "Intel silicone": `npx electron-builder --mac --x64`
* For both Mac and Intel silicone (combined image): `npx electron-builder --mac --universal`

## NOT TESTED: Create executable binaries for Linux

This should be as easy as running `npx electron-builder .` without options. Because, since we are building on Ubuntu, the builder will assume that we want to build for Linux.

Also, by default, since we run `electron-builder` on Ubuntu, `.deb` file for a "Debian-based Linux distributions" like Ubuntu will be created.

__Misc. options:__

* You can also specify `--linux` to create binaries for the specific Linux platform you are building on. Run `npx electron-packager . --platform=linux`

* To build a Linux `zip` target on Ubuntu, run: `npm run dist -- --linux --x64` add this to `package.json`:

  ```json
  "build": {
    "linux": {
      "target": "zip"
    }
  }
  ```

### To build for a specific Linux platform

* Build an executable file for Linux 64-bit: `npx electron-packager . --platform=linux --arch=x64`
* Build an executable file for Linux 32-bit: `npx electron-packager . --platform=linux --arch=ia32`
* Build an executable file for Linux ARM: `npx electron-packager . --platform=linux --arch=armv7l`
* Build an executable file for Linux ARM64: `npx electron-packager . --platform=linux --arch=arm64`
* Build an executable file for Linux all architectures: `npx electron-packager . --platform=linux --all`

## NOT TESTED: Create executable binaries for all platforms and all architectures

* TODO: NOTE: The following commands need to be verified:

* Build an executable file for all platforms: `npx electron-packager . --all`
* Build an executable file for all platforms and all architectures: `npx electron-packager . --all --arch=all`
