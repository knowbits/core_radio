# How to install `just` -

* `just` is an alternative to `make` that is written in Rust.
* Github: <https://github.com/casey/just>

## INSTALL `just` on Ubuntu

1. Use "cargo" to install "just", since it is a Rust app. Run the following commands:

    ```bash
    sudo apt update; sudo apt install rustc
    cargo install just
    ```

2. Add the following line to `~/.bashrc` or `~/.zshrc`:

    ```bash
    export PATH="$HOME/.cargo/bin:$PATH"
    ```

3. Verify the installed version with:

    ```bash
    just --version
    ```

   * Check the "version" against the latest release: [GitHub](https://github.com/casey/just)
