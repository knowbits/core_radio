# "Development Containers" standard

* Official page for the standard <https://containers.dev>

> "An open specification for enriching containers with development specific content and settings.""

1. Overview: <https://containers.dev/overview>
2. Spec (devcontainers.json): <https://containers.dev/implementors/spec>
1. Tools and services: <https://containers.dev/supporting>


## "VS Code Remote Development"

* Options: WSL, SSH, Containers, Github Codespaces

* <https://code.visualstudio.com/docs/remote/remote-overview>

* Home page: <https://code.visualstudio.com/docs/devcontainers/containers>

* Github repo: 
  * <https://github.com/Microsoft/vscode-remote-release>
  * "Visual Studio Code Remote Development: Open any folder in WSL, in a Docker container, or on a remote machine using SSH and take advantage of VS Code's full feature set."


# VS Code Development Containers

* Main page: "Developing inside a Container"
  * <https://code.visualstudio.com/docs/devcontainers/containers>
  
* "Dev Containers tutorial"
  * <https://code.visualstudio.com/docs/devcontainers/tutorial>

* VS Code EXTENSION: "Visual Studio Code Dev Containers"

  * Marketplace URL  <https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers>
  * Extension id: ms-vscode-remote.remote-containers

* Repo: "A Node.js sample project for trying out Dev Containers"
  * <https://github.com/Microsoft/vscode-remote-try-node>

* Containers make a great development environment because you can:

  1. Develop with a consistent, easily reproducible toolchain on the same operating system you deploy to.
  2. Quickly swap between different, separate development environments and safely make updates without worrying about impacting your local machine.
  3. Make it easy for new team members / contributors to get up and running in a consistent development environment.
  4. Try out new technologies or clone a copy of a code base without impacting your local setup.


* Misc USEFUL wrt WSL 2 and Dev Containers
  * Many usefult tips here: <https://code.visualstudio.com/docs/devcontainers/containers>
  
  * HOW TO: "Open a WSL 2 folder in a container on Windows"
    * <https://code.visualstudio.com/docs/devcontainers/containers#_open-a-wsl-2-folder-in-a-container-on-windows>
    * A) EITHER: From WSL project: If a project is open in WSL the run this command (Ctrl+P) to open the folder that is already opene in WSL : "Dev Containers: Reopen in Container"
    * B) OR: From Windows: Select "Dev Containers: Open Folder in Container..." and choose a WSL folder using the local \\wsl$ share (from the Windows side).
    
---

## TOOLS: Define and Run Dev Containers locally and remote

1. OVERVIEW of Tools and Services: <https://containers.dev/supporting>


---

## DevPod - A tool 

* DevPod tool
  * <https://devpod.sh>
  * GUI or CLI: Define a Dev Container for your IDE: IntelliJ, VS Code etc. 

  * Devpod Desktop (GUI application): 
    * Windows etc.
    * <https://devpod.sh/docs/getting-started/install>

  * DevPod CLI:
    * https://devpod.sh/docs/getting-started/install 
    * Useful for managing DevPod directly from a terminal.
    * Install on Linux on AMD 64:
      * `curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" && sudo install -c -m 0755 devpod /usr/local/bin && rm -f devpod`

  * Sample projects: 
    * Python
    * Node JS
    * Go
    * Rust
    * Java
    * PHP
    * C++
    * Dotnet
    
* ARTICLE: Remote Development made simple with DevPod
  * <https://www.loft.sh/blog/remote-development-devpod>
  * VS Code, Visual Studio, and IntelliJ products can leverage a devcontainer.json file. 
  * On the provider side, GitHub Codespaces, CodeSandbox, and DevPod support it.

  * The "devcontainer.json" schema reference: https://containers.dev/implementors/json_reference>

