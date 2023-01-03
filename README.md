# Nix flake development environment example

This repo provides an example [Nix flake][flakes] that outputs a Nix [development
environment][env].

## Prerequisites

In order to use this starter template, you need to have [Nix installed][install]
and [flakes enabled][enable].

## Explore this flake

To see what this flake provides:

```shell
nix flake show
```

Or as JSON:

```shell
nix flake show --json
```

As you can see, this flake outputs `default` development environments
(`devShells`) for a variety of architectures:

- `aarch64-darwin` (macOS on Apple Silicon)
- `aarch64-linux` (Linux on ARM64)
- `x86_64-darwin` (macOS on AMD/Intel)
- `x86_64-linux` (Linux on AMD/Intel)

## Using the environment

There are two ways to use the [Nix development environment][env] provided in
this flake:

1. You can clone this repo and run `nix develop` inside of it:

   ```shell
   git clone https://github.com/nix-dot-dev/nix-flake-example
   cd nix-flake-example
   nix develop
   ```

2. You can run `nix develop` and provide the flake reference to this repo:

   ```shell
   nix develop github:nix-dot-dev/nix-flake-example
   ```

This will likely take some time, as Nix needs to install the tools provided in
the environment. Once that's finished, you should be greeted by a welcome message
and then enter a [Bash] shell with a `bash-5.1$` prompt.

This dev environment provides several tools:

- [Node.js]
- [Python]
- [Go]
- [Terraform]

You can see that these tools are installed in your local [Nix store][store] by
running commands like these:

```shell
which node
which npm
which python
which go
```

In all cases, you should see paths of this form:

```shell
/nix/store/${LONG_HASH}-${PACKAGE_NAME}/bin/${EXECUTABLE_NAME}
```

That means that if you run `node`, `npm`, `python`, and so on you'll use
versions of those tools in the Nix store and _not_ versions installed in
directories like `/usr/bin`.

> **Note**: If you have [direnv] installed, you can also enter this
> flake-provided development environment by running `direnv allow`. Once you've
> done that, you will automatically enter the environment every time you
> navigate to this directory.

[bash]: https://gnu.org/software/bash
[direnv]: https://direnv.net
[enable]: https://nixos.wiki/wiki/Flakes#Enable_flakes
[env]: https://nixos.org/explore
[flakes]: https://nixos.wiki/wiki/Flakes
[go]: https://go.dev
[install]: https://nixos.org/download
[nix.dev]: https://nix.dev
[node.js]: https://nodejs.org
[python]: https://python.org
[store]: https://nixos.org/manual/nix/stable/command-ref/nix-store
[terraform]: https://terraform.io
