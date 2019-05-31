{ nixpkgs }:

let
  compilers = builtins.attrNames nixpkgs.haskell.packages;
in

nixpkgs.stdenv.mkDerivation rec {
  name = "available-ghc-versions";

  shellHook = ''
    set -eu

    echo "Available ghc compiler versions:"
    echo -e "${builtins.concatStringsSep "\n" compilers}"

    exit
  '';
}
