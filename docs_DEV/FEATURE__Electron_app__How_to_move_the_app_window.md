# FEATURE: Electron app: How to move the app window

> NOTE: Currently we cannot drag the title bar, since the window is frameless and transparent.

RESEARCH NOTES:

----

## A: Move app by dragging a specific area of the window

In Electron, you can make a "frameless window" movable by using the `-webkit-app-region: drag" CSS property.

This property allows you to specify regions of the window that can be used to drag the entire window around.

For example, you can make a custom title bar draggable by applying -webkit-app-region: drag to the title bar element.

  ```html
  <body>
    <div id="title-bar" style="-webkit-app-region: drag">
      My Custom Title Bar
    </div>

    <div id="content">
      <!-- Your content goes here -->
    </div>
  </body>
  ```

Not all elements need the `-webkit-app-region` property. This property is only needed for elements that you want to behave differently than the default behavior in a frameless Electron window.

If you set -webkit-app-region: drag on an element, that element (and its children, unless overridden) will be draggable and will not receive most mouse events, which makes it act like a title bar.

If you set -webkit-app-region: no-drag on an element, that element will not be draggable and will receive all mouse events, which makes it act like a regular interactive element.

So, you only need to use -webkit-app-region on elements that you want to be draggable or on elements inside a draggable area that you want to be interactive. Other elements can be left as they are.

----

## B: Move app by dragging "the whole page"

Yes, you can make the whole page draggable in Electron by applying -webkit-app-region: drag to the body element. However, this will make all elements including buttons and input fields draggable, which means they will not receive click events. To make an element clickable, you need to explicitly set -webkit-app-region: no-drag on it.

  ```html
  <body style="-webkit-app-region: drag">
    <div id="content" style="-webkit-app-region: no-drag">
      <!-- Your content goes here -->
    </div>

    <button style="-webkit-app-region: no-drag">
      Click me
    </button>
  </body>
  ```

In this example, the whole page is draggable, but the #content div and the button are clickable.

Please note that this approach might not work as expected if your content includes complex interactive elements, as it might be difficult to correctly set -webkit-app-region: no-drag on all clickable areas. It's usually better to designate specific areas of the window as draggable (like a custom title bar) and leave the rest of the window as non-draggable.

----
