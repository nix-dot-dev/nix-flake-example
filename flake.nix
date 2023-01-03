{
  # If you wish, you can provide flakes with a description string. This string is
  # shown if you run `nix flake show` to get information about a flake.
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
  };

  # Outputs are what the flake provides (packages, NixOS configurations, dev
  # environments, and more). Flakes *must* have outputs or else they are... kind
  # of pointless! In fact, you can think of flakes as a way of sharing Nix code
  # with others.
  outputs = { self, nixpkgs }:
    let
      # A set of systems to provide outputs for. In Nix flakes, many output
      # types, like packages and development environments, need to be for
      # specific systems.
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      # Helper function to provide per-system outputs.
      nameValuePair = name: value: { inherit name value; };
      genAttrs = names: f: builtins.listToAttrs (map (n: nameValuePair n (f n)) names);
      forAllSystems = f: genAttrs supportedSystems (system: f {
        # Passing a system attribute to `nixpkgs` produces a system-specific
        # Nixpkgs
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      # Development environments provided by the flake
      devShells = forAllSystems ({ pkgs }: {
        # When you specify a `default` environment, you can enter it by running
        # `nix develop` with no arguments. In other words `nix develop` is the
        # equivalent of `nix develop .#default`.
        default = pkgs.mkShell {
          # The packages provided in the environment
          buildInputs = with pkgs; [
            python310 # Python 3.10
            go_1_19 # Go 1.19
            nodejs-18_x # Node.js 18
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
    };
}
