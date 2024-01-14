/*
 * This script removes all locale files except for the "en-US.pak" from the
 * "locales" subfolder in the target platform's "build" folder of the Electron app.
 *
 * This script is run _after_ the app is packaged, but _before_ the installer is built.
 *
 * It is run by the "postinstall" script in "package.json".
 *
 * TODO: Running this script causes error when building on MacOS.
 *       NOTE: Works when building for Windows 64-bit (on Ubuntu WSL2).
 *
 *  => Removed the following from package.json:
 *
 *   "extraResources": [
 *     "locales/en-US.pak"
 *   ],
 *   "afterPack": "./scripts/remove-locales.js"
 */
const fs = require('fs');
const path = require('path');

/**
 *
 */
module.exports = async function (context) {

  // The "electron-builder" provides a context to the "afterPack" lifecycle hook,
  // which includes the "appOutDir" property. This property points to the directory
  // containing the packaged application (different for each "target platform").

  // Get the path to the app's directory
  const appDir = context.appOutDir;

  // Construct the path to the locales directory
  const localesDir = path.join(appDir, 'locales');

  // Read the contents of the locales directory
  fs.readdir(localesDir, (err, files) => {
    if (err) throw err;

    // Loop through each file in the locales directory
    //
    for (const file of files) {
      // If the file is not "en-US.pak", delete it
      if (file !== 'en-US.pak') {
        fs.unlink(path.join(localesDir, file), err => {
          if (err) throw err;
        });
      }
    }
  });
};
