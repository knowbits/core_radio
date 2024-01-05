# FEATURE: HTML: Button to view the full source of the loaded page

RESEARCH: Get the HTML of the loaded page

----
The short answer is **no**, you cannot read the entire source of a loaded HTML page using JavaScript.

This is because the source code is the original HTML document that was sent by the server, before any modifications by JavaScript or the browser¹.

The source code may also include some information that is not accessible by JavaScript, such as the DOCTYPE declaration, comments, or conditional comments².

 However, you can read the **current state** of the HTML document using JavaScript, which reflects the changes made by JavaScript or the browser.

This is done by accessing the `document` object and its properties, such as
`document.documentElement.outerHTML`

 or

`document.documentElement.innerHTML`¹.

These properties will return the HTML content of the entire document or the `` element, respectively³.

Note that these properties may not return the exact same HTML as the source code, as they may change the case, formatting, or attributes of some elements².

Source: Conversation with Bing, 03/01/2024

 (1) javascript - How do I get the HTML source from the page ... - Stack .... https://stackoverflow.com/questions/1367587/how-do-i-get-the-html-source-from-the-page.

(2) javascript - Get entire content of page? - Stack Overflow. https://stackoverflow.com/questions/866073/get-entire-content-of-page.

(3) How to Show the Source Code of Any Web Page in Your Page using JavaScript. https://blog.kevinchisholm.com/javascript/show-source-code-of-another-web-page/.

(4) undefined. http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js.

----
