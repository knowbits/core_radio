# Developer resources

## INSPIRATIONAL: Other Electron apps

* LIST: [Electron apps](https://www.electronjs.org/apps)

* Publication app: ["Zettlr"]([text](https://github.com/Zettlr/Zettlr))
  * _"Your One-Stop Publication Workbench"_
  * E.g.: Section on how to set up a "Development environment" for Electron, yarn, etc:
    * <https://github.com/Zettlr/Zettlr?tab=readme-ov-file#contributing-code>

----
## DEV TOOL: TERMINAL: Use `gh` tool with "Github Copilot"

* `gh`: Commands: https://cli.github.com/manual/gh
   * NOTE: OUTDATED? `hub`: Might be obsolete now..use `gh` instead. 
   * INSTALL: `$ gh extension install github/gh-copilot`

* Authenticate `gh` with GitHub account: 
   * `gh auth login`

* "GitHub Copilot" is available as an "extension" in `gh`:

   * INSTALL `$ gh extension install github/gh-copilot`
   * UPGRADE: `$ gh extension upgrade gh-copilot`

   * USAGE: `$ gh copilot config "The question"  # OR: explain, suggest.`

   * Example: `$ gh copilot explain "How can i create a shell script that will compress, minify and bundle the tailwind classes that i use in my CSS and HTML?"`


----
## WEB DEV: Usefool tools: Validate HTML, CSS

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

* Use "Material Design Web Components"
  * https://m3.material.io
  * https://material-web.dev/about/intro
  * https://github.com/material-components/material-web?tab=readme-ov-file
  * Is a library that brings the Material Design system to web components using Lit. 
  * It offers a collection of UI components inspired by Material Design guidelines. 
  * These components can be customized to align with your design system's visual style.

  * Material Web Components is developed and maintained by the Material Components team at Google. The team is responsible for creating and maintaining the Material Design system and its various implementations, including Material Web Components.

  * The Material Components team at Google is composed of designers and developers who work together to ensure that the components adhere to the latest Material Design guidelines, are well-documented, and provide a high-quality user experience. They actively maintain and update the repository, addressing bug reports, adding new features, and providing support to the community.

  * By leveraging their expertise and collaboration, the Material Components team ensures that Material Web Components remain up-to-date, reliable, and aligned with the evolving standards of Material Design.

  * The repository for "Material Web Components" is located at https://github.com/material-components/material-components-web-components.

  * Material Web Components is an implementation of the Material Design system using web components. The repository contains the source code, documentation, and examples for the library. It provides a collection of customizable and accessible web components that follow the Material Design guidelines. These components can be used to create modern and visually consistent user interfaces.

  * Feel free to explore the repository to learn more about Material Web Components, contribute to the project, or integrate the components into your own web applications.

Other web component frameworks: 

In addition to ING's Lion and the libraries mentioned earlier, there are several other web component libraries created with Lit that you can explore for leveraging existing W3C web components. Here are a few more examples:

Lit-UI: Lit-UI is a collection of UI components built with Lit. It provides a set of customizable and reusable components for building web applications. The components in Lit-UI follow the web component standards and can be easily customized to match your design system.

Fast Lit: Fast Lit is a library that combines the power of Lit and the design principles of Microsoft's Fluent UI. It offers a set of composable and customizable components that follow the web component standards. These components can be tailored to fit your design system's requirements.

Coral Spectrum: Coral Spectrum is an open-source library developed by Adobe that provides a set of web components built with Lit. These components follow the web component standards and can be customized to match your design system. Coral Spectrum offers a range of UI components such as buttons, forms, dialogs, and more.

Vaadin Components: Vaadin Components is a collection of customizable web components created by Vaadin, a company specializing in web development tools and frameworks. These components are built with Lit and follow the Material Design guidelines. They cover a wide range of UI elements, including buttons, grids, forms, and more, making them a versatile choice for building modern web applications.


* OR: Use "Lion" web components: 
  * Based on "Lit".
  * Guides: <https://lion-web.netlify.app/guides>
  * GitHub: <https://github.com/ing-bank/lion>

  * ING's Lion web components are generally well-regarded. 
  * They are a set of highly performant, accessible, and flexible Web Components1. They provide an unopinionated, white-label layer that can be extended to your own layer of components123.
  * Here are some key features of Lion web components:

    1. High Performance: They are focused on great performance in all relevant browsers with a minimal number of dependencies1.
    2. Accessibility: They aim at compliance with the WCAG 2.2 AA standard to create components that are accessible for everybody1.
    3. Flexibility: They provide solutions through Web Components and JavaScript classes which can be used, adopted, and extended to fit all needs1.
    4. Modern Code: Lion is distributed as pure es modules1.
    5. Developers may extend Lion into their customized component library, either adding ad-hoc functionality or styling2. One user mentioned that they were pleased to update their implementation to use Lion3.

  * ARTICLE (2021): [Create a design system with Lion web components](https://medium.com/ing-blog/create-a-design-system-with-lion-web-components-b9ff86a17a84)
  * Q&A with Thomas Allmer (ING developer): 
    * <https://www.infoq.com/articles/ing-open-sources-lion-web-component>

* Use "Lightning CSS": 
   * A Rust tool for: CSS parsing, transformation, bundling, and minifier.

* Introduce CSS framework? 
   * Candidates: "Open Props" (Google), Tailwind CSS, Bulma CSS (flexbox)
   * Tailwind: Has "CSS reset" ?
   * USER: "Tailwind Typography" (plugin) 
      * I use it after Tailwind "*resets all the css*": 
      * => Get consistent typography across the entire app and different browsers.

* Add a "colour scheme": 
   * READ: Stephanie Eckles: Colour scheme in CSS etc: 
      * <https://moderncss.dev/12-modern-css-one-line-upgrades>

   * READ: "Color for the Color-challenged" (if you suck at picking colors):
      * <https://ferdychristant.com/color-for-the-color-challenged-884c7aa04a56>

   * Use "Shoelace" built in "Theme" feature: Light/Dark/System
      * Shoelace also provides a set of themes that are compatible with its components and can be easily customized with CSS variables1. These themes include a light theme, a dark theme, and a system theme that adapts to the user’s OS preference2. You can use any of these themes by adding a link to the corresponding CSS file in your HTML head3. 
      * For example, to use the "light" theme, you can add this: `<link rel="stylesheet" href="https://www.npmjs.com/package/@shoelace-style/shoelace" />`
      * Or, create your own theme by following the instructions on the Shoelace website: 
         * https://shoelace.style/getting-started/themes#creating-themes

* Create an "Audio Streams Editor" - as a "Web Component"
   * Consider using: Lit, "Nano Stores" (state store), Open Props, Shoelace, Alpine.js.

* Use "Tauri" instead of Electron to build a native app. 

  * See <./docs_DEV/Tauri_alternative_to_Electron_for_crating_native_apps.md>

  * READ: "Making Rust binaries smaller by default"
     * <https://kobzol.github.io/rust/cargo/2024/01/23/making-rust-binaries-smaller-by-default.html>
     * Cargo by default now uses `strip = 'debuginfo'` for the `release` profile unless debuginfo is explicitly requested for some dependency. This new default will be used for any profile that does not enable debuginfo anywhere in its dependency chain. 
     * => This article looks at how a developer noticed that Rust binaries were unnecessarily large and then developed and submitted a fix for it.

* **"PWA"**: Also offer "Core Radio" as a "PWA".
   * As a "web app" that is stored locally on the device/computer. That works offline too.
   * See [PowerPWA: Boilerplate for PWAs](https://github.com/mvneerven/pure-pwa)
      *  An Ultra-Lean, Web Components enhanced, no-build, no-dependencies boilerplate for PWAs, using only the Modern Web

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
