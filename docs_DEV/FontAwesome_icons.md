# How to include FontAwesome icons in a web page

```html
<!--
  Load FontAwesome icons to be used in the "menu bar".

  CSS styling conventions for selecting FontAwesome icon categories:
    "fas" for Solid, "far" for Regular, "fal" for Light, "fad" for Duotone,
    and "fab" for Brands

  "FontAwesome stylesheet":

  The FontAwesome stylesheet is a CSS file that defines classes for each icon.
  When you add these classes to an element in your HTML, the corresponding icon
  will be displayed.

  Preloading the "FontAwesome stylesheet" can improve performance by starting
  to download the stylesheet sooner.

  This can be especially beneficial if your website uses a lot of FontAwesome icons,
  as it allows the icons to start loading earlier and be ready by the time they"re
  needed.
-->
<link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" as="style">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

```
