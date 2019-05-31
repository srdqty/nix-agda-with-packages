let
  pkgs = import ./nix/nixpkgs {};

  agda = import ../default.nix {
    Agda = pkgs.haskellPackages.Agda;
    fetchgit = pkgs.fetchgit;
    ghcWithPackages = pkgs.haskellPackages.ghcWithPackages;
    glibcLocales = pkgs.glibcLocales;
    makeWrapper = pkgs.makeWrapper;
    stdenv = pkgs.stdenv;
    symlinkJoin = pkgs.symlinkJoin;
  };

in
  pkgs.stdenv.mkDerivation {
    name = "agda-test-shell";

    buildInputs = [
      pkgs.ncurses # Needed by the bash-prompt.sh script
      (agda.agdaWithPackages (pkgs: with pkgs; [ial agda-stdlib]))
    ];

    shellHook = builtins.readFile ./nix/bash-prompt.sh;
  }
