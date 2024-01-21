# Tauri

----

## FEATURES

* <https://tauri.app>
* Build an optimized, secure, and frontend-independent application for multi-platform deployment.

* Scoped Filesystem: Improved security of file interactions
* App Storage: Use a canonical location to store user data
* GitHub Action: Build your Tauri binary for macOS, Linux, and Windows
* Self Updater: Update Tauri Apps from within themselves

> Tauri allows developers to use their existing knowledge of HTML, CSS, and JavaScript to build applications that can run on Windows, macOS, and Linux.

> Tauri supports a lot of frontend frameworks and libraries, for example, React.js, Next.js, Vite, and Svelte kit2. So, you can certainly use your existing knowledge of HTML, CSS, and JavaScript to build applications with Tauri123. It’s also worth noting that Tauri provides a utility called create-tauri-app which offers templates for vanilla HTML/CSS/JavaScript and many frontend frameworks like React, Svelte, and Yew1.

----

## Getting started with Tauri

* <https://tauri.app/v1/guides/getting-started/setup/html-css-js/>
* <https://www.freecodecamp.org/news/build-a-cross-platform-app-with-next-and-tauri/>
* <https://tauri.app/v1/guides/getting-started/setup/>

----

## Comparison: Tauri vs. Electron (vs Iconic, React Native, Flutter etc)

Tauri apps are much lighter than Electron apps due to their WebView approach.

* A sample application built with Electron that weighs more than 52MB would weigh much less, around 3MB, when built with Tauri.
* <https://blog.logrocket.com/tauri-electron-comparison-migration-guide/>

Tauri apps also outperform Electron apps in terms of:

* Performance, launch time, and memory consumption1.
* <https://dev.to/alxnddr/electron-vs-tauri-for-your-next-project-2dna>

Tauri may be more difficult to learn and use:

* Particularly for developers who are not familiar with Rust.
* <https://github.com/tauri-apps/tauri>

----

## WebKitGTK

* full-featured port of the WebKit rendering engine, suitable for projects requiring any kind of web integration, from hybrid HTML/CSS applications to full-fledged web browsers.

We drive development of the GStreamer WebKit backend and support full integration of video into page content and the HTML canvas element. Currently we are working to finish support for WebAudio and WebRTC.

<https://webkitgtk.org/>

----

## WebKit

* Web browser engine used by: Safari, Mail, App Store, and many other apps on macOS, iOS, and Linux
* A fast, open source web browser engine.
* <https://www.webkit.org/>

WebView2 on Windows
Webview OS applications
                                                                                                     WebView is a system component used in both Android and iOS operating systems that allows application>

----

## WebKitGTK

* <https://webkitgtk.org/reference/webkit2gtk/stable/WebKitWebView.html>
* Platforms supported: Linux, Windows, macOS, iOS, Android, BSD, Haiku, OS/2, and Solaris.
* WebKitWebView is a widget displaying Web content, such as a Web page.
  * It extends the WebKitWebContainer interface.

Resources:

* <https://webkitgtk.org/reference/webkit2gtk/stable/WebKitWebContainer.html>
* <https://webkitgtk.org/reference/webkit2gtk/stable/WebKitWebView.html>
* <https://webkitgtk.org/reference/webkit2gtk/stable/WebKitWebContext.html>

----
ChatGPT: QUESTION 1: EB: How can i create a Tauri desktop application based on my static html file (core_radio.html), similar to the ELECTRON app that i have already created?

Creating a Tauri application from a static HTML file involves several steps. Here's a step-by-step guide:

1. Install Tauri CLI globally:

```bash
npm install -g @tauri-apps/cli
```

2. Initialize a new Tauri project:

```bash
npx create-tauri-app
```

During the initialization process, you'll be asked a series of questions. For the "Select the Frontend Framework" question, choose "no bundler/static" since you're using a static HTML file.

3. Once the project is initialized, replace the `src-tauri/src/main.rs` file with the following:

```rust
#![cfg_attr(
  all(not(debug_assertions), target_os = "windows"),
  windows_subsystem = "windows"
)]

fn main() {
  tauri::Builder::default()
    .run(tauri::generate_context!())
    .expect("error while running tauri application");
}
```

4. Replace the content of the `src-tauri/tauri.conf.json` file with the following:

```json
{
  "build": {
    "distDir": "../path/to/your/static/files",
    "devPath": "../path/to/your/static/files"
  }
}
```

Replace `../path/to/your/static/files` with the path to your static HTML files.

5. Build your Tauri application:

```bash
npm run tauri build
```

This will create a standalone application in the `src-tauri/target/release` directory.

Please note that Tauri requires Rust to be installed on your machine. If you haven't installed Rust yet, you can do so by following the instructions on the [official Rust website](https://www.rust-lang.org/tools/install).

----
ChatGPT: QUESTION 2: EB: How can i have a "top bar menu" in Tauri using icons that i define in my HTML?

Tauri doesn't natively support a top bar menu like Electron does. This is because Tauri aims to be a lean framework and leaves the UI entirely up to the web technology used.

However, you can create a custom top bar menu in your HTML/CSS and use Tauri's JavaScript API to interact with the system. Here's a basic example:

1. Define your menu in HTML:

```html
<div id="menu">
  <button id="minimize">-</button>
  <button id="maximize">+</button>
  <button id="close">x</button>
</div>
```

2. Style it with CSS:

```css
#menu {
  position: fixed;
  top: 0;
  right: 0;
}

#menu button {
  /* Add your styles here */
}
```

3. Use Tauri's JavaScript API to interact with the window:

```javascript
const { app, Window } = require('@tauri-apps/api');

document.getElementById('minimize').addEventListener('click', () => {
  Window.getCurrent().then(window => window.minimize());
});

document.getElementById('maximize').addEventListener('click', () => {
  Window.getCurrent().then(window => window.isMaximized().then(isMaximized => {
    if (isMaximized) {
      window.unmaximize();
    } else {
      window.maximize();
    }
  }));
});

document.getElementById('close').addEventListener('click', () => {
  app.exit(0);
});
```

This will create a basic top bar menu with minimize, maximize, and close buttons. You can add more buttons and functionality as needed.

----
ChatGPT: QUESTION 3: EB: How can i make a justfile that will build my Tauri app for Windows, Linux and Mac?

You can use the `tauri build` command to build your Tauri application for Windows, Linux, and macOS. Here's an example:

```bash
tauri build --target all
```

This will create a standalone application for each platform in the `src-tauri/target/release` directory.

The "justfile" for the Tauri app build prcess will look like this:

```bash
# Build the Tauri app for Windows, Linux, and macOS
build:
  tauri build --target all

# Build the Tauri app for Windows
build-windows:
  tauri build --target windows

# Build the Tauri app for Linux
build-linux:
  tauri build --target linux

# Build the Tauri app for macOS

build-macos:
  tauri build --target macos

# Misc. targets:

# TODO: Verify which of these Tauri "targets" are valid and which are not.

clean:
  tauri clean

dev:
  tauri dev

info:
  tauri info

init:
  tauri init

lint:
  tauri lint

promote:
  tauri promote

run:
  tauri run

start:
  tauri start

upgrade:
  tauri upgrade

validate:
  tauri validate

version:
  tauri version

```

----
