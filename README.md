# 3DS Template for Nix
Either use direnv or `nix develop .` to enter the shell, devkitarm (the 3DS toolchain)
will get automatically installed, and added to `PATH`

## Building
To build you can use the `Makefile` that was provided in the libctru's official examples
or the simple `./build.sh` script, `3dslink` for quick testing should already be in your
`PATH` as well, to build *and* link, you can use the `./build-and-link.sh <IP ADDRESS>`
script
