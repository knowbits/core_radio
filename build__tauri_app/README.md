# INSTALLING: Tauri + "Vanilla" template (No framework, only HTML, CSS, JS)

> This template should help get you started developing with Tauri in vanilla HTML, CSS and Javascript.

----

## 

----

## MISC: GO THROUGH THIS!

Open DevTools in a production build:
https://tauri.app/v1/guides/debugging/application

Custom title bar, max, min, close buttons etc
https://tauri.app/v1/guides/features/window-customization

Add a "Custom native menu":
see the Rust code: at 1m45s
https://youtu.be/-X8evddpu7M?si=90wUAPUarZtW2R67

Creating a Custom Titlebar
https://tauri.app/v1/guides/features/window-customization/
Icons

Icons
Tauri ships with a default iconset based on its logo. This is NOT what you want when you ship your application.
To remedy this common situation, Tauri provides the icon command that will take an input file ("./app-icon.png" by default) and create all the icons needed for the various platforms.
https://tauri.app/v1/guides/features/icons

Javascript API:
@tauri-apps/api
https://tauri.app/v1/api/js

Experimental: Build Windows apps on Linux and macOS
https://tauri.app/v1/guides/building/cross-platform/#experimental-build-windows-apps-on-linux-and-macos

Opening Devtools Programmatically
https://tauri.app/v1/guides/debugging/application/
https://tauri.app/v1/guides/debugging/application/#opening-devtools-programmatically


Using the Inspector in Production
To create a debug build, run the tauri build --debug command.
https://tauri.app/v1/guides/debugging/application/#using-the-inspector-in-production


----
## TODO: HOW TO: "FRAMELESS" Tauri app (from ChatGPT):

To make a Tauri app frameless on Windows, you need to modify the Tauri configuration file (`tauri.conf.json`) and add some custom CSS styles.

Here are the steps to make a Tauri app frameless on Windows:

1. Open the `tauri.conf.json` file in your Tauri project.

2. Add the `"window"` section if it doesn't already exist. It should be at the same level as the `"build"` section. Here's an example:

   ```json
   {
     "build": {
       ...
     },
     "window": {
       "title": "My Tauri App",
       "width": 800,
       "height": 600
     }
   }
   ```

3. Add the `"frameless"` property with the value `true` to the `"window"` section:

   ```json
   "window": {
     "title": "My Tauri App",
     "width": 800,
     "height": 600,
     "frameless": true
   }
   ```

4. Save the `tauri.conf.json` file.

5. Open the `src-tauri/tauri.js` file in your Tauri project.

6. Add the following JavaScript code to the `tauri.init()` function to inject CSS styles that make the window frameless:

   ```javascript
   tauri.init({
     ...
     tauri: {
       ...
       windows: {
         frameless: true
       }
     },
     ...
   });
   ```

7. Save the `tauri.js` file.

By following these steps, you should be able to make your Tauri app frameless on Windows. When you rebuild and run your app, the window will no longer have the default frame with the title bar and minimize/maximize/close buttons.

Please note that making the app frameless removes the typical window controls, so you'll need to implement custom controls within your app if needed.

If you have any further questions or need assistance with Tauri development, please let me know.

----

## TAURI : 3rd party Tauri resources

* Repo: "Awesome Tauri Apps, Plugins and Resources"
  * <https://github.com/tauri-apps/awesome-tauri>

* VIDEO: "Rust Tauri 1.0 - Quick Intro - Rust Desktop App"
  * By Jeremy Chone.
  * <https://www.youtube.com/watch?v=kRoGYgAuZQE>
  * Github repo: <https://github.com/jeremychone-channel/rust-tauri-intro>
  * Stikkord: Rollup, Typescript, web components, Rust code etc.

* VIDEO : "Awesome App" - also by Jeremy Chone
  * See <https://awesomeapp.org> for a more complete application in Rust and Tauri.
  * TITLE: "Base desktop application code with Tauri, Native Web Components and SurrealDB (follow the VMES app architecture)"
  * <https://www.youtube.com/watch?v=BY_ZjPGqJJk>
  * Repo: <https://github.com/awesomeapp-dev/rust-desktop-app>

* VIDEO (2023): " Mobile Apps with Vite & Tauri, and a Look Into the Future"
  * By Jonas Kruckenberg
  * <https://youtu.be/cVYlih-jFwI?si=ic45YBQoLBz46o5v>

* VIDEO (2022): "Tiny and secure native apps using Vite + Tauri"
  * By Jonas Kruckenberg
  * <https://youtu.be/_dJDjVG1wWs?si=r2zJNd0agSpWtKfd>

* VIDEO: Tauri & ReactJS - Creating Modern Desktop Apps (read desc.)
  * <https://youtu.be/BbZmLXBDGnU?si=eUhQOR6Ea5AtLSy5>
  * New Vite template: <https://github.com/elibroftw/modern-desktop-app-template>
  * Part 2 - Creating UI with Mantine <https://youtu.be/SopeeK1TVoQ>
  * Part 3 - Persistent storage & Notifications - <https://www.youtube.com/watch?v=CyZ2OwfPBqc>
  * Part 4 - Adding Translations: <https://www.youtu.be/43kXglTCEHI>
  * Part 5 - Migrating to Vite: <https://youtu.be/HEjEZuBREXY>
  * Part 6 - fs API & Rust invocation <https://youtu.be/S7_DNL06Mcs>
  * Part 7 - programmatically resizing a window <https://www.youtube.com/watch?v=WSgmnXOyJtQ>

  * Video possibilities for the future:
  * Part 8 - Icons + Packing a website into a desktop app (google keep) <https://www.youtube.com/watch?v=uNDar53iwkU>
  * Part 9 - Building for Windows, Linux, and Mac OS X using GitHub Actions + Optimizations <https://www.youtube.com/watch?v=rHK2keBNSHo>
  * Part 10: How to auto-update <https://www.youtube.com/watch?v=ZXjlZBisYPQ>
  * Part 11: System Tray, Managing State, & Event Listening <https://youtu.be/Xg4gczPKTuk>

----

## Tauri Javascritp API and Tauri configuration

### Tauri configuration: `tauri.conf.json`

* Available configuration options: <https://tauri.app/v1/api/config/>

### Tauri Javascript APIs

* List of all the APIs in `@tauri-apps/api`
  * <https://tauri.app/v1/api/js/>
  * LIST of APIs: app, cli, clipboard, dialog, event, fs, globalShortcut, http, mocks, notification, os, path, process, shell, tauri, updater, window
  * NOTE: The APIs in the `@tauri-apps/api` package are accessible with `window.__TAURI__.<name-of-api>`
    * Requires: `build.withGlobalTauri` in `tauri.conf.json` must be set to `true`

* The `window` Javascript API
  * API to: 1) create windows, 2) communicate with other windows, 3) manipulate the current window.
  * Accessible with `window.__TAURI__.window`

  * The APIs must be added to `tauri.allowlist.window` in `tauri.conf.json`:
    * See available settings: <https://tauri.app/v1/api/js/window>

  * The "Allowlist" for the `window` API:
    * <https://tauri.app/v1/api/config/#windowallowlistconfig>

----

## DEVELOPMENT: Install a "Tauri" development environment on Ubuntu (WSL2)

* Prerequisites: <https://tauri.app/v1/guides/getting-started/prerequisites>

* Debian: <https://tauri.app/v1/guides/getting-started/prerequisites#setting-up-linux> (Debian)

* Install Debian/Ubuntu dependencies:

```bash
sudo apt update
sudo apt install libwebkit2gtk-4.0-dev \
    build-essential \
    curl \
    wget \
    file \
    libssl-dev \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev
```

* Install Rust

```bash
# Install "rustup": Installs and manages Rust, Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

rustc --version # Check Rust version
cargo --version # Check Cargo version
```

* NOTE: To keep "Rust" updated run: `rustup update`

----

## DEVELOPMENT: Create a new "Tauri" project

* From <https://tauri.app/v1/guides/getting-started/setup/>

> The easiest way to scaffold a new project is the `create-tauri-app` utility.

```bash
# Install the "create-tauri-app" utility

cargo install create-tauri-app --locked
cargo create-tauri-app
```

* => We used the "Vanilla" template (no framework, only HTML, CSS, JS)
  * Here are the questions and our answers:

    ```text
    Project name: build__tauri_app
    Choose which language to use for your frontend
    TypeScript / JavaScript
    Choose your package manager: npm
    Choose your UI template: Vanilla
    Choose your UI flavor: JavaScript

    Template created!
    ```

* Install the npm dependencies: `cd build__tauri_app;npm install`
  * NOTE: `package.json`: Contains the `"@tauri-apps/cli"` Javascript dependency (in "devDependencies").

* Start the development server: `npm run dev`

### => Resulting project files and folders

* => These folders and files will be created:
  * `./src/` (html, css, js)
  * `./src-tauri/` (Rust/Cargo/Tauri config and build files)
  * `package.json` (Javascript config and npm dependencies).

* => The `./src-tauri/` folder contains the "Rust" code and the "Tauri" configuration files.

  * `tauri.conf.json`: the configuration file for the "Tauri app". See <https://tauri.app/v1/api/config>
  * The `Cargo.toml`: the "Rust" project file, with Rust crate dependencies and versions. See <https://doc.rust-lang.org/cargo/reference/manifest.html>.
  * The `build.rs`: the "Rust" build file.
  * `./src/main.rs`: the main "Rust" file that configures the "Tauri" app.
  * `./icons/`: A set of default "app icons" for the target platforms. Swich these out! See <https://tauri.app/v1/guides/features/icons>

----

## DEVELOPMENT: Install the "Tauri CLI"

* From: <https://tauri.app/v1/guides/getting-started/setup/html-css-js#create-the-rust-project>

> The "Tauri CLI" utility helps you build, develop, and deploy your Tauri application.

* Install the "Tauri CLI": `cargo install tauri-cli`

* Crate a new "Tauri" project: `cargo tauri init`
  * Initializes a minimal Rust project for an Tauri app.

* Start the development server: `cargo tauri dev`
  * Builds the Tauri app and opens it in "webview".
  * Hot-reload: Change to the web app => the "WebView" updates automatically (if the tooling allows it).
  * Also, changes to Rust files are rebuilt automatically => And app restarts automatically.

----

## DEVELOPMENT: Update Cargo packages (Rust dependencies)

* From <https://tauri.app/v1/guides/development/updating-dependencies#update-cargo-packages>

* Install the `cargo-edit` utility: `cargo install cargo-edit`
  * Repo: <https://github.com/killercup/cargo-edit>

* Update all Cargo packages: `cargo upgrade`
  * => This will update all the "Rust" dependencies in the `Cargo.toml` file to the latest versions.

```bash
# Install the "cargo-upgrade" utility
cargo install cargo-upgrade

# Update the "Rust" dependencies
cargo upgrade
```

----

## DEVELOPMENT: VS Code: Recommended IDE Setup

* [VS Code](https://code.visualstudio.com/)
* [Tauri](https://marketplace.visualstudio.com/items?itemName=tauri-apps.tauri-vscode) - [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)

----

## BUILD: PREREQUISITES: Set up `WebView2` on Windows 10/11

> Tauri uses `WebView2` to run the app (render web content) on Windows.

* The easiest way is to install `WebView2` using the "Evergreen Bootstrapper".
  * <https://developer.microsoft.com/en-us/microsoft-edge/webview2/#download-section>
  * NOTE: The bootstrapper script will try to determine the correct architecture and version for your system.

----

## BUILD: Build the "Tauri" app for "Windows" on Ubuntu (WSL2)

### Prerequisites

* Install "mingw-w64" for "Windows" target: `sudo apt install mingw-w64`
  * Needed for Rust's "gnu" target on Windows 64-bit.

* Add "Windows" target to "Rust": `rustup target add x86_64-pc-windows-gnu`

  * Veridy that the "Windows" target is installed: `rustup target list`

* CHECK if NEEDED: Install wine for "Windows" target: `sudo apt install wine`

* Install nsis on Ubuntu: `sudo apt install nsis`
  * NSIS: Nullsoft Scriptable Install System
  * Needed to create the "Windows" installer.

* Install "makensis.exe" on Ubuntu using "wine":
  * `wget https://downloads.sourceforge.net/nsis/nsis-3.06.1-setup.exe`
  * `wine nsis-3.06.1-setup.exe`
  * `makensis.exe --version`

* Copy `WebView2.dll` to the `./src-tauri/` folder so that it is included in the "Windows" build:
  * NOTE: The `WebView2Loader.dll` file is needed to run the "Tauri" app on "Windows".
  1. NOTE: For this to work one probably first has to run `cargo tauri build --target x86_64-pc-windows-gnu` at least once, so that the `WebView2.dll` file is being downloaded.
  2. Find the `WebView2Loader.dll` file in Tauri's `target` folder: `find . -name WebView2Loader.dll`
  3. Copy the `WebView2Loader.dll` file to the `./src-tauri/` folder: `cp /path/to/WebView2Loader.dll ./src-tauri/WebView2Loader.dll`

* Include the `WebView2Loader.dll` file in the "Tauri" build:
  1. Edit the `tauri.conf.json` file.
  2. Add `"resources": ["./WebView2Loader.dll"]` inside the `bundle` section.

  ```json
  {
    "bundle": {
      "icon": "./icons/icon.ico",
      "resources": ["./WebView2Loader.dll"]
    }
  }
  ```

### Finally, build the "Tauri" app for "Windows 11, 64-bit" target on Ubuntu (WSL2)

* See: Building for Windows: <https://tauri.app/v1/guides/building/windows>

* See ["WebView2 Installation Options"](https://tauri.app/v1/guides/building/windows#webview2-installation-options)
  * => Need to specify how to bundle the `WebView2` installer (Microsoft) in the `tauri.conf.json` file.

* Build the "Tauri" app for "Windows": `cargo tauri build --target x86_64-pc-windows-gnu`
  * OPTIONAL: Might also add `--bundles nsis` to only build the NSIS installer.

* => The "Windows" installer (`.exe`) will be created in the `./src-tauri/target/x86_64-pc-windows-gnu/release/bundle/nsis/` folder.

  * Copy it e.g. to the Windows "Desktop" folder and run it to install the app.

### TODO: Build Windows" target on Linux (for the "msvc" target instead of "gnu")

> Tauri officially only supports the "MSVC" Windows target.
> The "MSVC" target is the "Microsoft Visual C++" target.

* See ["Experimental: Build Windows apps on Linux and macOS"](https://tauri.app/v1/guides/building/cross-platform#experimental-build-windows-apps-on-linux-and-macos)

### TODO: Use the Docker container to build the "Windows" app on Ubuntu instead

* See: <https://tauri.app/v1/guides/building/docker>

----

## DEVELOP: GIT: Which Tauri files to include/exclude in "git"

* Include in "git":
  * `./src-tauri/Cargo-lock`: The "Rust" dependencies lock file.
    * NOTE: Used to ensure that the same versions of the dependencies are installed on all machines.

* Exclude from "git":
  * `./src-tauri/target/` (Rust build files)

* => Add these lines to the `.gitignore` file:

  ```gitignore
  # Tauri
  src-tauri/target/
  ```

----
