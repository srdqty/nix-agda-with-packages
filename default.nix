{ Agda
, fetchgit
, ghcWithPackages
, glibcLocales
, makeWrapper
, stdenv
, symlinkJoin
}:

let
  # GHC as a compilation target
  ghcBackend = ghcWithPackages (pkgs: with pkgs; [
    ieee754
    text
  ]);

  # GHC used to build GenerateEverything.hs files, for example
  ghcBuild = ghcWithPackages (pkgs: with pkgs; [
    filemanip
    filepath
  ]);

  agdaPackages = {
    agda-stdlib = import ./pkgs/agda-stdlib {
      inherit Agda fetchgit ghcBuild stdenv;
    };

    # iowa agda library
    ial = import ./pkgs/ial {
      inherit Agda fetchgit stdenv;
    };
  };

  agdaWithPackages = import ./lib/with-packages.nix {
    inherit
      Agda
      agdaPackages
      ghcBackend
      glibcLocales
      makeWrapper
      stdenv
      symlinkJoin;
  };
in
{
  inherit agdaPackages agdaWithPackages;
}