{
  # If you wish, you can provide flakes with a description string. This string is
  # shown if you run `nix flake show` to get information about the flake. To see
  # this description string, run this command:
  # `nix flake show github:nix-dot-dev/nix-flake-example`
  description = "nix.dev starter template for Nix flakes";

  # Flake inputs are Nix code dependencies. What you don't see here in
  # `flake.nix` is that each of these inputs has an entry in `flake.lock` that
  # "pins" the input to a specific revision. This makes `flake.nix` and
  # `flake.lock` inseparable. With flakes, the pinning mechanism previously
  # provided by tools like Niv is built in.
  inputs = {
    # Nixpkgs is by far the largest Nix codebase in the world, providing tens of
    # thousands of packages and utilities for the Nix language. Here, we
    # essentially import Nixpkgs using a flake reference. `github` is the prefix
    # for GitHub repos, but other prefixes include `gitlab` for GitLab repos,
    # `path` for directories in the local filesystem, and more.
    nixpkgs.url = "github:NixOS/nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    # Although Nixpkgs and flake-utils are extremely common, you can use any
    # valid flake as an input.
  };

  # Outputs are what the flake provides (packages, NixOS configurations, dev
  # environments, and more). Flakes *must* have outputs or else they are... kind
  # of pointless! In fact, you can think of flakes as a way of sharing Nix code
  # with others.
  outputs = { self, nixpkgs, flake-utils }:
    let
      # A set of systems to provide outputs for. In Nix flakes, many output
      # types, like packages and development environments, need to be for
      # specific systems. This flake supports these systems:
      supportedSystems = [
        "x86_64-linux" # Linux on AMD/Intel
        "aarch64-linux" # Linux on ARM64
        "x86_64-darwin" # macOS on AMD/Intel
        "aarch64-darwin" # macOS on Apple Silicon
      ];
    in
    flake-utils.lib.eachSystem supportedSystems (system:
      let
        # This creates a system-specific version of Nixpkgs and stores it in a
        # variable
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # When you specify a `default` environment, you can enter it by running
        # `nix develop` with no arguments. In other words `nix develop` is the
        # equivalent of `nix develop .#default`.
        devShells.default = pkgs.mkShell {
          # The packages provided in the environment. Because the packages are
          # included in the `pkgs` attribute set, each is pinned to a specific
          # revision of Nixpkgs via `flake.lock`, which makes the environment
          # reproducible (as anyone else using this environment uses the same
          # Git revision).
          packages = with pkgs; [
            python3 # Python 3.10 in this revision of nixpkgs
            go # Go 1.19
            nodejs # Node.js 18
            terraform
          ];

          # Nix development environments support environment variables. You
          # can set variables like `DEBUG = true` or `ENV = "production"`. But
          # beware: we do *not* recommend using environment variables to provide
          # secrets!
          MESSAGE = "This is only available inside the environment";

          # Shell hooks are optional scripts that are run every time you enter
          # the development environment.
          shellHook = ''
            echo "Welcome to an example Nix development environment for nix.dev!"
          '';
        };
      });
}
