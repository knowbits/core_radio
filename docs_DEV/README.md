# Developer resources

## INSPIRATIONAL: Other Electron apps

* LIST: [Electron apps](https://www.electronjs.org/apps)

* Publication app: ["Zettlr"]([text](https://github.com/Zettlr/Zettlr))
  * _"Your One-Stop Publication Workbench"_
  * E.g.: Section on how to set up a "Development environment" for Electron, yarn, etc:
    * <https://github.com/Zettlr/Zettlr?tab=readme-ov-file#contributing-code>

## The `hub` utility for working with Github repositories

* Install: `$ sudo apt-get install hub`
* List of useful commands: `$ tldr hub`

* A wrapper for `Git` that adds commands for working with GitHub-based projects.
* If set up as instructed by hub alias, one can use `git` to run `hub` commands.

* More information: <https://hub.github.com>

* ARTICLE by `Alpine.js` creator Caleb Porzio:
  * <https://calebporzio.com/give-your-git-command-superpowers>

## Validate HTML, CSS

* _"W3C: Markup Validation Service"_ (HTML only)
  * <https://validator.w3.org/#validate_by_input>

* _"The W3C CSS Validation Service"_ (HTML with CSS or CSS only)
  * Check Cascading Style Sheets (CSS) and (X)HTML documents with style sheets
  * <https://jigsaw.w3.org/css-validator/#validate_by_input>

* EXPERIMENTAL for HTML5: _"W3C: Nu Html Checker"_
  * <https://validator.w3.org/nu/#textarea>
  > "This tool is an ongoing experiment in better HTML checking"

## TO DO: FEATURE REQUESTS

* MENU: Add "Help" button
  * Show a popup/modal with Help related info for the app.
  * Keyboard navigation
    * ARROW KEYS to focus radio stations.
    * SPACE/ENTER to play/stop radio station.
  * Explain the menu items:
    * Refresh, Save preferences, View source,
    * Electron only: "Chromium Developer tools", Close button.
  * How we use the HTML 5 "audio" element: There is no buffering of the audio streams so there only a play/stop button, thus no pause/resume button.
  * Customise the list of radio stations: by editing the "streams" array in the `./src/core_radio.html` file (save on Desktop or other local folder).
    * Link to the HTML in Github: <https://github.com/knowbits/core_radio/blob/main/src/core_radio.html>

* About button:
  * Show a popup/modal with information about the app.
    * Version number.
    * Support.
    * License.
    * Credits.
    * Show a link to the GitHub repository.
    * Show a link to the "About" page on the GitHub repository.

    * Web devevelopment libraries:
      * "Shoelace" web components: <https://shoelace.style>
      * "Shoelace" icons: <https://shoelace.style/icons>
      * Lit library: <https://lit.dev> for creating web components (custome HTML elements).
      
    * Native desktop app development tools:
      * Electron: <https://www.electronjs.org>
        * Tool to create a desktop app from a web app (static HTML).
        * Relies on the Javascript ecosystem, npm etc.
      * Electron Builder tool: <https://www.electron.build>
        * Tool to package and build a ready for distribution "Electron app" for macOS, Windows and Linux with “auto update” support.
    * Misc dev and build tools:
      * Code editor: VS Code <https://code.visualstudio.com> and `nano` <https://www.nano-editor.org>
      * `bash` scripts: for processing and validating the static HTML file to prepare for Electron app build step.

* FEATURE: HTML: [Save preferences in a local file](./FEATURE__HTML__Save_preferences_in_a_local_file.md)
  * E.g. Maintain an indivdual list of your preferred radio streams.
  * OR: Consider using "remoteStorage" - An API to persiste user preferences etc on a server.
    * <https://github.com/FrigadeHQ/remote-storage>
    * `remoteStorage` is a simple library that combines the localStorage API with a remote server to persist data across browsers and devices.
    * They offer a free hosted community server at `https://api.remote.storage`

* FEATURE: Add "Auto-update" for the native Electron apps:
  * <https://www.electronjs.org/docs/latest/tutorial/updates>

## TO DO: IMPROVEMENTS, OPTIMIZATIONS

* Use "Tauri" instead of Electron to build a native app. 
  * See <./docs_DEV/Tauri_alternative_to_Electron_for_crating_native_apps.md>

* **"PWA"**: Also offer "Core Radio" as a "PWA".
   * Web app ffline web appthat is stored locally on the device/computer. 

* Create a "radio-player" web component
  * A "custom HTML element": that encapsulate the "audio" and "button" elements in a web component.
  * BENEFITS: Improves readability of the HTML. Encapsulates cmplex logic inside a component. Reuse. Reduced complexity etc.
  * NOTE: The building blocks of HTML ("elements") can now be extended by creating "custom elements".

  * See: <https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_custom_elements>
  * Consider using the "Lit" library: since it optimises DOM rendering and is already used by "Shoelace" web component library.
    * <https://lit.dev>
    * <https://lit.dev/docs/components/overview/>
    * <https://lit.dev/docs/components/properties/>
    * <https://lit.dev/docs/components/events/>
    * <https://lit.dev/docs/components/lifecycle/>
    * <https://lit.dev/docs/components/directives/>
    * <https://lit.dev/docs/components/templates/>
    * <https://lit.dev/docs/components/styles/>
    * <https://lit.dev/docs/components/shadow-dom/>
    * <https://lit.dev/docs/components/async/>

* IMPROVE CSS: **"Menu bar"** layout: Consider using a "flexbox" layout for the menu bar.
  * See: <https://css-tricks.com/snippets/css/a-guide-to-flexbox/>

* OPTIIMZE: **Shoelace** download: Load selected web components from local folder (instead of CDN)
  * "Bundling": <https://shoelace.style/getting-started/installation#bundling>
  * Example: Bundling with `npm` and `webpack`: <https://github.com/shoelace-style/webpack-example>
  * "Cherry picking" web components from local folder:
    * <https://shoelace.style/getting-started/installation#cherry-picking>

* Change **"CSS Reset"** scheme: Consider using **"Reboot"** from Bootstrap
  * <https://getbootstrap.com/docs/5.3/content/reboot>
  * Built on "Normalize".

* SEO: Make the web app searchable by using "meta" tags etc: [OPTIMIZE: SEO: Add "meta" tags](./OPTIMIZE__SEO__Add_meta_tags.md)

* [OPTIMIZE: CSS: FontAwesome icons: Only load the ones we actually use](./OPTIMIZE__CSS__FontAwesome_Only_load_the_icons_that_are_actually_used.md)

* Improve CSS: [How I'm Writing CSS in 2024](https://leerob.io/blog/css#user-experience)
  * Minfy and compress the CSS file:
    * Remove all comments, spaces, line breaks, etc.
    * Remove all unused CSS styles.
    * Use compression/minfying tools like: PurgeCSS, CSSNano, and Brotli
  * Proper Caching: Stylesheets should not re-download unless changed.
    * This can be achieved by generating "hashed file names" to enable safe, immutable caching
  * Fast Font Loading:
    * Fonts should load as fast as possible and minimize layout shift.
    * A properly configured `@font-face` rule can improve font loading performance.
      * NOTE: "Google Fonts" already does this for you:
        * A "CSS" is downloaded with a `@font-face` rule that points to the font files on Google's servers.
    * Use `font-display: swap;` or use `font-display: optional;`:
      * Tell the browser it's okay to use a "fallback font" until the custom font is loaded.
    * Use `preload` to load fonts earlier in the page lifecycle.
    * Host fonts locally: Reduces the number of network requests (HTTP, DNS).
    * Use `WOFF2` format (if possible): the most compressed font format.
  * Consider "StyleX" (CSS-in-JS library)
    * <https://leerob.io/blog/css#stylex>
    * <https://stylexjs.com/docs/learn/thinking-in-stylex/>
  * "CSS Modules"
    * <https://leerob.io/blog/css#css-modules>
    * "Lightning CSS" supports "CSS Modules"
      * <https://lightningcss.dev>

----

## Electron app: Developer resources

* VIDEO: "[How to BUILD a DESKTOP app with HTML, CSS & JavaScript using Electron JS!](https://www.youtube.com/watch?v=TkAiVKfWtjI)".
  * Code on [GitHub](https://github.com/TylerPottsDev/electron-note-app).

* "[Electron Quick Start](https://www.electronjs.org/docs/tutorial/quick-start)".

* "[Electron Documentation](https://www.electronjs.org/docs/latest/)".
* "[Electron API docs](https://www.electronjs.org/docs/latest/api/app)".
* "[Electron API Demos](https://www.electronjs.org/#get-started)".

### Electron: Misc. turotrials and courses

* Youtube tutorials on Electron app development:
  * Quick intro: 14 min: [01 - Setting up an Electronjs desktop app with basic setup](https://www.youtube.com/watch?v=WZmevodgNEA)
  * Traversy: [Build an Electron App in Under 60 Minutes](https://www.youtube.com/watch?v=kN1Czs0m1SU)
    * Code for the project on [GitHub](https://github.com/bradtraversy/electronshoppinglist).
    * See his full 6h [Udemy course](https://www.udemy.com/course/electron-from-scratch) below.
  * 2016, 9 min: [Creating Desktop Apps with Electron](https://www.youtube.com/watch?v=ojX5yz35v4M)
  * [ELECTRON: why people HATE it, why devs USE it](https://www.youtube.com/watch?v=G1K0Mb-rLBU)

* Electron courses
  * 1h: [Learn Electron in Less than 60 Minutes - Free Beginner's Course](https://www.youtube.com/watch?v=2RxHQoiDctI)
    * By Gary Simon, DesignCourse, see <http://designcourse.com>
    * Code for the project on [GitHub](https://is_the_code_somewhere.com)
  * Traversy: 6h: [Electron From Scratch: Build Desktop Apps With JavaScript](https://www.udemy.com/course/electron-from-scratch)

## Electron tools

### Electron Forge

* An all-in-one tool for packaging and distributing Electron applications.
* <https://www.electronforge.io>

### Electron Fiddle

* Available as a "dev tool" - download and install on Windows, Mac or Linux.
* The easiest way to get started with Electron.
* <https://www.electronjs.org/fiddle>

*Fiddle is built on Microsoft's excellent [Monaco Editor](https://microsoft.github.io/monaco-editor), the same editor powering VS Code.

* "Electron Fiddle lets you create and play with small Electron experiments. It greets you with a quick-start template after opening – change a few things, choose the version of Electron you want to run it with, and play around. Then, save your Fiddle either as a GitHub Gist or to a local folder. Once pushed to GitHub, anyone can quickly try your Fiddle out by just entering it in the address bar."
