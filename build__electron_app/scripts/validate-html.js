/*
 * Validate HTML 5 using the "w3c-html-validator" npm package.
 *
 * NOTE: "w3c-html-validator" uses W3C's "Nu validator".
 *
 * Use from shell script like this:
 *   $ node validate-html.js "the_html_file.html" > "html_validation_results.txt"
 *
 * Install the npm package with:
 *   $ npm install w3c-html-validator
 */
//
// TODO: Could not make this script work. It caused error wwwwhen run from the shell script
// TODO: Maybe because the "w3c-html-validator" npm package is not maintained.
// TODO: Also tried "html5-validator" npm package, but it also caused errors.
// TODO: SOLUTION: Probably need to call "node_modules/.bin/html-validator" directly from the shell script.
//
const validator = require('w3c-html-validator');
const fs = require('fs');

fs.readFile(process.argv[2], 'utf8', (err, data) => {
  if (err) {
    console.error(err);
    process.exit(1);
  }

  validator.validateText(data)
    .then((result) => {
      console.log(result);
      if (result.messages.length > 0) {
        process.exit(1);
      }
    })
    .catch((err) => {
      console.error(err);
      process.exit(1);
    });
});
