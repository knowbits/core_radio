# Storybook : Create W3C Web Components

* You can use Storybook to create W3C web components. 

> Storybook is a development environment for UI components that allows you to develop and test your components in isolation. 

> It supports various frameworks including React, Angular, Vue, and as of version 3.4.0, it also supports "Polymer 2".

----

## GUIDE: Use Storybook with web components:

1. Install Storybook CLI as a global dependency. You need a version of at least v.3.4.0.
2. After the CLI has been installed, the `getstorybook` command will install Storybook for your project.
3. This will install Storybook through npm (even though you use bower for Polymer). It will also generate a `.storybook` directory that contains Storybook configuration.
4. To start Storybook, run `npm storybook` and open up `http://localhost:6006`. 
5. You can then start building "stories" for your web components.

For example, if you have a web component `progress-bar` with a few properties, you can add a storybook for this component by adding a file `progress-bar.stories.js`.

Remember, Storybook allows you to browse a component library, view the different states of each component, and interactively develop and test components. It's a great tool for developing web components in isolation, ensuring they function regardless of the connection between them.

: [How to combine Web Components with Storybook; a match made in ... - Medium](https://medium.com/storybookjs/how-to-combine-web-components-with-storybook-a-match-made-in-heaven-9d9939eedc76)
: [How To Build JS Components with Storybook | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-build-js-components-with-storybook)
: [Storybook for web components on steroids - DEV Community](https://dev.to/open-wc/storybook-for-web-components-on-steroids-4h29)

----
## Here is your text formatted into markdown:

# Storybook with Lit

Storybook can be used with Lit to create standard W3C web components. Here's a basic guide on how to use Storybook with Lit:

1. **Setup new Vite project**: Start by setting up a new Vite project. You can do this with the command `npm create vite@latest my-webcomponents -- --template lit-ts`.
2. **Install Storybook**: Next, install Storybook using the command `npx sb@latest init --builder storybook-builder-vite`. Storybook uses webpack by default, but since we are using Vite, we would rather use the `storybook-builder-vite` plugin.
3. **Vite config changes**: In your `vite.config.js` file, you might need to comment out the line `external: /^lit/,` if you want to publish standalone components.
4. **Typescript config changes**: Because we have added Storybook, we need to exclude `.stories.ts` files from the TypeScript compilation, otherwise when we publish to NPM they will be included.
5. **Storybook config changes**: The Storybook config needs to tweak the Vite config for `storybook-builder-vite` to work. 
   * We need to include and exclude some packages from the Vite config.

Once you've made these changes, you can start building stories for your web components. For example, if you have a web component `progress-bar` with a few properties, you can add a storybook for this component by adding a file `progress-bar.stories.js`.

Remember, Storybook allows you to browse a component library, view the different states of each component, and interactively develop and test components. It's a great tool for developing web components in isolation, ensuring they function regardless of the connection between them.

References:
- : [Publish Web Components using Vite, Lit and Storybook](https://dev.to/leon/vite-lit-and-storybook-43f)
- : [How to combine Web Components with Storybook; a match made in ... - Medium](https://medium.com/storybookjs/how-to-combine-web-components-with-storybook-a-match-made-in-heaven-9d9939eedc76)
- : [Multiple components stories with Lit Element + Storybook](https://stackoverflow.com/questions/66259461/multiple-components-stories-with-lit-element-storybook)
- : [ViteJS Config](https://vitejs.dev/config/)



