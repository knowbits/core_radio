# Alpine.js

## Summary of benefits
>
> Alpine.js is a powerful and minimal JavaScript framework that allows you to compose behavior directly in your markup. It's often compared to `jQuery` for the modern web. A powerful tool for building interactive web interfaces with a small footprint.

> `Alpine.js` is not used to create _"Single Page Applications (SPAs)"_.

> Alpine.js **"templates"** are HTML enhanced with Alpine.js _"directives"_ (`x-`), adding interactivity through a reactive and declarative approach.

> `Alpine.js` provides a collection of 15 attributes, 6 properties, and 2 methods. With a small API profile, it provides reactivity in a clean format, augmented with some surrounding niceties like "eventing" and a "central store".

> It's a great tool for enhancing static websites or server-side rendered apps, and for building widgets.

----

## Developer resources

### Official resources

* Official: "[Alpine.js](https://alpinejs.dev)".

* Repo: "[Alpine.js GitHub repo](https://github.com/alpinejs/alpine)"

* Download the "[Alpine.js minimal version](https://unpkg.com/alpinejs@3.10.3/dist/cdn.min.js)"

### Learning: Courses, guides, articles, tutorials etc

* Getting started guide: "[Getting Started with Alpine.js - The Ultimate Guide](https://daily.dev/blog/alpine-js-the-ultimate-guide)"

* INTRO: "[Intro to Alpine.js: A JavaScript framework for minimalists](https://www.infoworld.com/article/3682135/intro-to-alpinejs-a-javascript-framework-for-minimalists.html)"

* COURSE: "[Learn Alpine JS in this free interactive tutorial](https://www.freecodecamp.org/news/learn-alpine-js-in-this-free-tutorial-course)"

----

## How to include `Alpine.js`` in your static HTML page

1. ["Installation — Alpine.js"](https://alpinejs.dev/essentials/installation) (OFFICIAL)

2. Stackoverflow: ["How to use JS Module for AlpineJS app to Static HTML"](https://stackoverflow.com/questions/75872345/how-to-use-js-module-for-alpinejs-app-to-static-html)

### Load `Alpine.js` directly from a CDN using `<script>` tag

You can load `Alpine.js` directly into your HTML from a CDN like [jsDelivr](https://www.jsdelivr.com) or [unpkg](https://unpkg.com).

```html
<script defer src="https://unpkg.com/alpinejs"></script>
```

Explanation: `defer` is used to ensure that the script is executed after the DOM has been parsed.

### Load `Alpine.js` from the local file system

1. Use the browser to manually find the version number of the latest release of `Alpine.js` by opening this URL in your browser:

    ```bash
    https://registry.npmjs.org/alpinejs
    ```

   * NOTE: The version number is listed under the `latest` key in the JSON response

2. Or you can use the `curl` to print the latest  `Alpine.js` version number to the terminal:

    ```bash
    curl -s https://registry.npmjs.org/alpinejs | jq -r '.["dist-tags"].latest'
    ```

3. Then download the latest version of `Alpine.js` using `curl`:

    ```bash
    curl -L -o alpinejs.min.3.13.3.js https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js
    ```

   * NOTE: Substitute with the latest version number that was found in the previous step.
   * NOTE: Downloads the "minified" version of `Alpine.js` (~ 43kB for v3.x.x).
   * Explanation: The `-L` options is needed to follow redirects.

4. Include the downloaded `Alpine.js` in your static HTML like this:

    ```html
    <script defer src="./lib/alpinejs.min.3.13.3.js"></script>
    ```

   * Explanation: The `defer` attribute ensures that the script is executed _after_ the DOM has been parsed.

* **"ES6 modules**: Include `type="module"` if you're using ES6 modules:

      ```html
      <script type="module" src="./js/alpine.3.4.3.js"></script>
      ```

  * ES6 modules are "deferred" by default., so you don't need to use the `defer` attribute.

  * The javascript will be downloaded with `CORS`:
    * => You will get a "CORS error" if your server doesn't support cross-origin requests.

### Load from local file system: Install `Alpine.js` using `npm`

1. **Install Alpine.js** using `npm`:

   ```bash
    npm install alpinejs
   ```

2. **Link to the JavaScript file**: In your HTML file, link to the JavaScript file where you imported Alpine.js. For example:

   ```html
    <script type="module" src="./your-javascript-file.js"></script>
   ```

* NOTE: ES6 modules are "deferred" by default, so you don't need to use the `defer` attribute⁵.

----

## How to use Alpine.js in your static HTML page

1. **Import Alpine.js**: Import Alpine into your JavaScript file and initialize it:

```javascript
import Alpine from 'alpinejs'
window.Alpine = Alpine
Alpine.start()
```

2. **Use Alpine.js**: Now you can use Alpine.js in your HTML. Here's an example:

```html
<div x-data="{ open: false }">
    <button @click="open = !open">Toggle</button>
    <div x-show="open">Hello World!</div>
</div>
```

Remember, for best results and efficient loading, use a **"reverse proxy cache"** to improve performance of serving static assets. Also, ensure that your server is configured to serve static files. For example, if you're using Apache, you can use the `mod_alias` module to serve static files⁵.

----

## ALpine.js: Key concepts

* [Alpine.js: Key concepts](https://alpinejs.dev/essentials/key-concepts)

1. **Reactivity**: Alpine.js provides reactivity in a clean format. This means that when the underlying data changes, the UI updates automatically. This is particularly useful for "widgets", which often need to respond to user interactions or data changes.

2. **Eventing**: This term is related to the event handling capabilities of Alpine.js. It allows you to listen for browser events on an element and react accordingly¹. For example, you can use the `x-on` directive to listen for a click event and toggle a variable's state². This is part of the reactivity system in Alpine.js, which enables the UI to update automatically when the underlying data changes².

3. **Central Store**: Alpine.js offers global state management through the `Alpine.store()` API⁶. You can define a store inside of an `alpine:init` listener or before manually calling `Alpine.start()`⁶. Once a store is defined, you can access data from any store within Alpine expressions using the `$store` magic property⁷. This allows you to share state across components and even modify properties within the store⁶. For example, you could create a 'darkMode' store and then use `$store.darkMode.toggle()` to switch between light and dark modes⁶.

----

## How to create an Alpine.js "widget"

Creating a widget in Alpine.js involves defining a component with its own state and behavior.

Here's a simple example of how to create a _"counter"_ widget:

```html
<!-- Include Alpine.js in "head" section of HTML -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Define the "widget" -->
<div x-data="{ count: 0 }">
    <button x-on:click="count++">Increment</button>
    <span x-text="count"></span>
</div>
```

Explanation:

* `x-data="{ count: 0 }"` declares a new component with a `count` property set to `0`. This is the component's state.
* `x-on:click="count++"` listens for a click event on the button and increments the `count` property when the event occurs.
* `x-text="count"` updates the text content of the span to reflect the current value of `count`.

`Alpine.js` allows you to create more complex widgets with additional features and functionality.

Remember, the `script` tag for including `Alpine.js` should be placed in the `head` of your HTML file.

1. [Start Here — Alpine.js](https://alpinejs.dev/start-here)

2. [Build modular app with Alpine.js](https://dev.to/keuller/build-modular-app-with-alpinejs-2ece)

3. [javascript - Reusable Alpine.js components?](https://stackoverflow.com/questions/65710987/reusable-alpine-js-components)

4. [How to create a reusable component in Alpine.js?](https://stackoverflow.com/questions/68037046/how-to-create-a-reusable-component-in-alpine-js)

----

## Alpine.js: Included components

Alpine.js offers a variety of `web components` that you can use to enhance your web applications. Here are some of them:

* **Dropdown**: A component for creating dropdown menus¹.
* **Modal**: A component for creating modal windows¹.
* **Accordion**: A component for creating accordion interfaces¹.
* **Carousel**: A component for creating carousel sliders¹.
* **Tabs**: A component for creating tabbed interfaces¹.
* **Notifications**: A component for creating notification pop-ups¹.
* **Radio Group**: A component for creating radio button groups¹.
* **Toggle**: A component for creating toggle switches¹.
* **Tooltip**: A component for creating tooltips¹.

In addition to these, `Alpine.js`` also provides integrations with <u>third-party libraries</u> for features like:

* Charts: _Chart.js, ApexCharts_.
* Text editors: _Trix, Quill, SimpleMDE_.
* Select inputs: _Select2, Choices.js_.
* Calendars & datepickers: _Flatpickr, Date Range Picker, FullCalendar_.
* Carousels: _Glide, Splide_.

Moreover, there are also some community-built components available:

* `Pinecone Router` (a client-side router)
* `Alpine.js Tash` (for rendering data in moustache syntax)
* `Alpine Wizard` (for building multi-step wizards)
* `Alpine $fetch` (a magic helper to integrate HTTP fetch requests directly within Alpine.js markup)³.

1. [UI Components — Alpine.js](https://alpinejs.dev/components)
2. [GitHub - alpine-collective/awesome: A curated list of awesome ....](https://github.com/alpine-collective/awesome)
3. [Using Web Components in Alpine.js - Raymond Camden](https://www.raymondcamden.com/2023/06/02/using-web-components-in-alpine)
4. [Alpine.js Playground - A set of ready to use Alpine.js examples with ....](https://alpinejs.codewithhugo.com/?type=components)
5. [GitHub - bcorpj/AlpineJS-ComponentX: The Alpine Components Package ....](https://github.com/bcorpj/AlpineJS-ComponentX)

----

## `Alpine.js`: OVERVIEW

Alpine.js is a simple and efficient alternative to other frontend frameworks such as Vue, React, and Angular¹.

It's particularly useful for:

* **Simple static websites or server-side rendered apps**: Alpine.js is well-suited for adding _interactive elements_ to the UI of simple static websites or server-side rendered apps¹.
  * This includes basic patterns like: modals, dropdowns, tabs, lists with filters, o
  * Or any component where its state is reduced to a couple of variables or a small list of items.

* **Replacing jQuery in legacy projects**: Alpine.js can replace `jQuery` in legacy projects as it covers all of the same functionality with a smaller library size and much more compact syntax.

* **Building widgets and easily creating client-side experiences**: Alpine.js is good for building "widgets" ("HTML enhanced with Alpine.js directives") and easily creating client-side experiences for websites that are mainly server-side rendered or static.

However, if your app is a "single-page application" (SPA) with most of its logic in the front end, a considerable component tree, and lots of state communication between components, you might be better off using a full-blown framework/library like `Vue` or `React`. Alpine.js is not really meant for tasks like routing or global state management.

* "[Introduction to Alpine.js | When to use it?](https://lightit.io/blog/when-to-use-alpine-js)"

----

## Alpine.js: Interoperability with "web components" (W3C standard)

It is quite straightforward to use web components in Alpine.js. The process involves defining a simple Alpine application and using web components within the HTML of the application. Alpine.js successfully adds the components to the DOM, but the attributes are updated after the `connectedCallback` event is fired. This can be fixed with `observedAttributes` and `attributeChangedCallback`¹.

* See ["Using Web Components in Alpine.js"](https://www.raymondcamden.com/2023/06/02/using-web-components-in-alpine)

Moreover, there are experiments with WebComponents and `Alpine.js` that demonstrate patterns for writing web components using the Alpine.js framework, using dedicated directives and magics.

* See: ["Web components with AlpineJS"](https://github.com/priand/alpinejs-webcomponents).

However, it's important to note that while Alpine.js can work with "web components", the specifics of how they interact can depend on the particularities of the web component library and the needs of your project.

1. OFFICIAL: [UI Components](https://alpinejs.dev/components)
2. REPO: [The Alpine Components Package](https://github.com/bcorpj/AlpineJS-ComponentX) - at _"bcorpj/AlpineJS-ComponentX"_ Github repo.

----
