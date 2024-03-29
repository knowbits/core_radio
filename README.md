# Core Radio (as a static HTML page)

A static .html file for playing audio streams from selected radio stations.

Easily edit the list of stations by modifying the "streams" JSON in the "script" section of the HTML page.

## Build and run the "Electron app" from source

* Clone the repository: `$ git clone https://github.com/knowbits/core_radio.git`
* Go to the project folder: `$ cd core_radio`
* Install `just` (a simple "make" alternative): [How to install `just``](./docs_DEV/how_to_install_just.md)
* Install Electron and other `npm` dependencies: `$ just install`
* Run the app from shell: `$ just start`

## Third party libraries

* Javascript framework: [Alpine.js](./docs_DEV/Alpine.js.md)

* Web components: [Shoelace](https://shoelace.style)
  * Uses ["Lit"](https://lit.dev) to creating web components (custom HTML elements).

* Icons: [Shoelace icons](https://shoelace.style/icons)

## Developer resources

* See [Developer resources](docs_DEV/README.md)

Here is how the "Core Radio" app looks installed on Windows 11:

![Radio Streams Player](./docs/SCREENSHOT_Core_Radio__as_web_app.png)

## Curated list of radio stations (streaming URLs)

* See [Curated list of radio stations](./docs/curated_list_of_radio_stations.md)

* See also [Related Radio Player prjects on GitHub](./docs/related_radio_player_projects.md)

## HOW TO: Play the radio streams on your local machine

1. Download "core_radio.html" and save it to your local machine.
2. Open the "core_radio.html" file in your preferred browser.
3. Click on the radio station you want to listen to.

## HOW TO: Add a new radio station / stream

1. Edit the "streams" JSON in the "script" section of the HTML page.

2. Add a new category of radio stations to the "streams" JSON

   * By adding a new JSON object to the "streams" JSON array:

    ```javascript
        {
            category: "SELF-1",
            categoryTitle: "My stations",
            streams: [
              { title: "P1", url: "http://lyd.nrk.no/nrk_radio_p1_ostlandssendingen_aac_h", type: "audio/aac" },
              { title: "Sport", url: "https://lyd.nrk.no/nrk_radio_sport_aac_h", type: "audio/aac" }
            ]
          },
    ```

3. Save the HTML page.

## HOW TO: Create a desktop shurtcut to a minimal "web app"

Create a shortcut on your desktop to open the html page as a minimal "web app".

The static HTML file will open as a "minmal" web app on your local machine.

* Windows: [How to create a "web app" shortcut on your desktop](docs/how_to__create_a_desktop_shortcut_on_Windows.md)

* Mac: [How to create a "web app" shortcut on your desktop](docs/how_to__create_a_desktop_shortcut_on_Mac.md)

## HOW TO: Build an "Electron app" from the HTML page

* See [HOW TO: Build an "Electron app" from the HTML page](./build__electron_app/README.md)

## HOW TO: Serve the web page from a web server

1. Copy the "core_radio.html" file to your web server.
2. Edit the "streams" JSON in the "script" section of the HTML page to add your preferred radio stations / streams.
3. Open  <https://yourdomain/core_radio.html> in your browser.

## HOW TO: Scrape the loaded web page, to get the Javascript-generated HTML

* See [HOW TO: Scrape the loaded web page](build__scrape_loaded_html_page/README.md)

### Contribution guidelines

* Writing tests (TBD)
* Code review (TBD)
* Other guidelines (TBD)

### Who do I talk to?

* Repo owner or admin (TBD)
* Other community or team contact (TBD)

### Useful MarkDown resources

* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)
