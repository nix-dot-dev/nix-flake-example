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

## Using the environment

To enter the [Nix development environment][env] provided by this flake:

```shell
nix develop
```

You should be greeted by a welcome message and then enter a [Bash] shell.

This dev environment provides several tools:

- [Node.js]
- [Python]
- [Go]
- [Terraform]

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

[bash]: https://gnu.org/software/bash
[enable]: https://nixos.wiki/wiki/Flakes#Enable_flakes
[env]: https://nixos.org/explore
[flakes]: https://nixos.wiki/wiki/Flakes
[go]: https://go.dev
[install]: https://nixos.org/download
[nix.dev]: https://nix.dev
[node.js]: https://nodejs.org
[python]: https://python.org
[terraform]: https://terraform.io
