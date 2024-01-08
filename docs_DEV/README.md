# Developer resources

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

* [FEATURE: Electron app: Move the Electron app window by dragging](./FEATURE__Electron_app__How_to_move_the_app_window.md)
  * NOTE: Currently we cannot move (by dragging) the Electron app, since is configured to be both frameless and transparent.

* FEATURE: Electron app : Create a Menu bar - as a row of buttons at the top of the app window
  * Use FontAwesome icons (SVG?) for the buttons?

  * A "Move" button to Drag and move the Electron app window.
    * (See [FEATURE: Electron app: How to move the app window](./FEATURE__Electron_app__How_to_move_the_app_window.md))

  * Menu button candidates:
    * Close app, Reload page, Open Chrome DevTools ,  About ("?" icon), Settings(cog wheel icon)
  * Misc. other candidates: Minimize app, Maximize app, Restore app (?).
    * A DEBUG button: [Button to view the full source of the loaded page](./FEATURE__HTML__Button_to_view_the_full_source_of_the_loaded_page.md)

* [FEATURE: HTML: Keep indivdual list of radio streams in a local file](./FEATURE__HTML__Keep_radio_streams_preferences_in_a_local_filed.md)

## TO DO: IMPROVEMENTS, OPTIMIZATIONS

* [OPTIMIZE: CSS: FontAwesome icons: Only load the ones we actually use](./OPTIMIZE__CSS__FontAwesome_Only_load_the_icons_that_are_actually_used.md)

* Improve CSS: [How I'm Writing CSS in 2024](https://leerob.io/blog/css#user-experience)

----

## Electron app: Developer resources

* Electron docs: <https://www.electronjs.org/docs/latest/>
* Electron API docs: <https://www.electronjs.org/docs/latest/api/app>

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
