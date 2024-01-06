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

## FEATURE REQUESTS

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

## IMPROVEMENTS, OPTIMIZATIONS

* [OPTIMIZE: CSS: FontAwesome icons: Only load the ones we actually use](./OPTIMIZE__CSS__FontAwesome_Only_load_the_icons_that_are_actually_used.md)
