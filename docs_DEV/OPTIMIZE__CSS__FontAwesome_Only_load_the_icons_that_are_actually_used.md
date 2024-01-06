# OPTIMIZE: CSS: FontAwesome icons: Only load the ones we actually use

## Preloading the stylesheet (CSS)

* Preloading the FontAwesome stylesheet can improve performance by starting to download the CSS stylesheet sooner.

  * This can be especially beneficial if your website uses a lot of FontAwesome icons,
as it allows the icons to start loading earlier and be ready by the time they're needed.

  * The FontAwesome stylesheet is a CSS file that defines classes for each icon. When you add these classes to an element in your HTML, the corresponding icon will be displayed.

## ChatGPT says: _"There are several ways to optimize the loading of FontAwesome icons to make it faster:"_

1. __Download FontAwesome Files and Serve Locally:__
   * Font Awesome gives you a huge number of icons for free and the ability to download and serve the files from your own server1. This helps with site speed since we don’t need to access an external server to serve fonts1.

2. __Preload the Necessary Font Files:__
   * Preloading allows the browser to start loading resources before they are actually needed1. This can be done by adding a rel="preload" attribute to your link tag, similar to how Google Fonts uses rel="preconnect".

3. __Use FontAwesome SVGs:__
   * If you don’t need to style the icons differently depending on their use, you can ditch the font files and use FontAwesome SVGs instead1. This can reduce the size of the files that need to be loaded.

4. __"Subset" Font Awesome:__
    * By subsetting Font Awesome, we can remove any unused glyphs from the font files it provides2. This will reduce the number of bytes transmitted over the wire, and improve performance2
