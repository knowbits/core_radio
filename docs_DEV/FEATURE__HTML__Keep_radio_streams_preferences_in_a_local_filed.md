# FEATURE: HTML: Keep radio streams preferences in a local file

See: https://stackoverflow.com/questions/10041480/what-is-the-difference-between-html5-localstorage-sessionstorage-session-and-cookies

RESEARCH: Access a local static file

----
To use the File System Access API in your HTML page, you need to include a <script> tag that loads the JavaScript code that interacts with the API.

For example, you can use the following HTML template to create a simple web app that lets you open and display a text file:

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>File System Access Demo</title>
</head>
<body>
  <h1>File System Access Demo</h1>
  <button id="open-button">Open File</button>
  <pre id="file-content"></pre>
  <script src="script.js"></script>
</body>
</html>
In the script.js file, you can use the File System Access API methods to request a file handle, read the file content, and display it in the <pre> element.

For example, you can use the following JavaScript code:

// Get the button and the pre elements
const openButton = document.getElementById("open-button");
const fileContent = document.getElementById("file-content");

// Add a click event listener to the button
openButton.addEventListener("click", async () => {
  // Show the file picker and get a file handle
  const [fileHandle] = await window.showOpenFilePicker();
  // Get a File object from the handle
  const file = await fileHandle.getFile();
  // Read the file as text
  const contents = await file.text();
  // Display the file content in the pre element
  fileContent.textContent = contents;
});
You can save these files in a local directory and open the HTML file in your browser. You should see a button that says “Open File”.

When you click on it, you should see a file picker dialog that lets you choose a text file from your local file system.

Once you select a file, you should see its content displayed in the web page.

You can learn more about the File System Access API and how to use it in your HTML page from the following sources:

File System API - Web APIs | MDN: This is the official documentation of the File System API, which explains its concepts, interfaces, and examples.

https://developer.mozilla.org/en-US/docs/Web/API/File_System_API

The File System Access API: simplifying access to local files: This is a tutorial that shows how to use the File System Access API to create a web app that can read and write files and directories on the user’s device.

https://developer.chrome.com/docs/capabilities/web-apis/file-system-access

Web Apps Can Interact With Your Filesystem Now: This is an article that introduces the File System Access API and its benefits and challenges for web developers.

https://www.howtogeek.com/devops/web-apps-can-interact-with-your-filesystem-now

----
Yes, a static local HTML page can be granted access to a specific file using the File System Access API, which is a web standard that enables web applications to directly read and write files and directories on the user’s device. This API requires the user’s permission and consent before accessing any files or folders. The user can also revoke the permission at any time1.

To access a specific file using the File System Access API, you can use the window.showOpenFilePicker() method, which returns a promise that resolves to an array of FileSystemFileHandle objects. Each handle represents a file that the user has selected. You can then use the handle to get a File object, which contains the file’s contents and metadata. For example, the following code snippet shows how to read the text content of a file selected by the user:

// Show the file picker and get a file handle const [fileHandle] = await window.showOpenFilePicker(); // Get a File object from the handle const file = await fileHandle.getFile(); // Read the file as text const contents = await file.text(); // Do something with the contents console.log(contents);

You can also use the window.showSaveFilePicker() method to save a file to the user’s device, or the window.showDirectoryPicker() method to access a directory and its contents. For more details and examples, you can check the documentation of the File System Access API.



RESOURCES:

1: The File System Access API: simplifying access to local files

https://developer.chrome.com/docs/capabilities/web-apis/file-system-access
2: File System API - Web APIs | MDN


https://developer.mozilla.org/en-US/docs/Web/API/File_System_API
