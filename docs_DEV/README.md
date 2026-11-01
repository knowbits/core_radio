# Developer resources

----
## TODO: Access "Open AI" from the new Gitlab repos + use the "NextWeb" client

* ARTICLE: Using gpt-4 for free with Github Copilot
  * <https://dev.to/hoaitx/using-gpt-4-for-free-with-github-copilot-1a3p>

* Gitlab repos of `copilot-gpt4-service` 

  * <https://gitlab.com/fatelulu/copilot-gpt4-service
copilot-gpt4-service>

  * <https://gitlab.com/aaamoon/copilot-gpt4-service> 

* Client app for AI chat: "NextWeb"
  * REPO: "ChatGPT-Next-Web"
  * A cross-platform ChatGPT/Gemini client app UI (Web / PWA / Linux / Win / MacOS).
  * <https://github.com/ChatGPTNextWeb/ChatGPT-Next-Web?tab=readme-ov-file>
  * Use it as a web-based app: <https://app.nextchat.dev>
  * Can be run locally..

----
## TODO: Configure the "history" shell utility

* See instructions in the VQ file: 
  * `LINUX - shell - history - How to use it effectively from terminal.txt`

----
`ag`: Quickly search the source code inside local files 

* "Silver Searcher" = `ag`
* `$ ag logging`  => Will list all files containing the string "logging"

* __Options:__
  * Example: `--json`: Search only JSON files.
    * NOTE: `ag --list-file-types`: Lists all supported file types.
  * `--files-with-matches`: Only list file names, not matched file content.

Alternatives
  * `jq`: Search inside JSON files.
  * `yq`: Search inside YAML files.

RELATED: `fzf` 
  * Search part of file names in subfolders

----
## Shell related 
* Web app: Explain a shell command: 
  * <https://explainshell.com>

* Use `gh` - the GitHub command utility 
  * `gh explain "how to search inside files"`

----
## Java in VS Code: 

* EXTENSION: "Oracle Java Platform Extension for Visual Studio Code"
   * <https://marketplace.visualstudio.com/items?itemName=Oracle.oracle-java>
   * Functionality, settings, keyboard shortcuts, VS Code commands, etc.

----
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

## TO DO: Electron and Tauri

* FEATURE: Add "Auto-update" for the native Electron apps:
  * <https://www.electronjs.org/docs/latest/tutorial/updates>

* Use "Tauri" instead of Electron to build a native app. 

  * See <./docs_DEV/Tauri_alternative_to_Electron_for_crating_native_apps.md>

  * READ: "Making Rust binaries smaller by default"
     * <https://kobzol.github.io/rust/cargo/2024/01/23/making-rust-binaries-smaller-by-default.html>
     * Cargo by default now uses `strip = 'debuginfo'` for the `release` profile unless debuginfo is explicitly requested for some dependency. This new default will be used for any profile that does not enable debuginfo anywhere in its dependency chain. 
     * => This article looks at how a developer noticed that Rust binaries were unnecessarily large and then developed and submitted a fix for it.

Web-app feature ideas and improvements (dialogs, web components, CSS, caching, PWA) moved to the
RadioNerds repo: `../RadioNerds/docs_DEV/BACKLOG__web_app_ideas.md`.

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
