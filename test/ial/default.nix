let
  pkgs = import ../nix/nixpkgs {};

  agda = import ../../default.nix {
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
    name = "test-ial";

    src = ./.;

    buildInputs = [
      (agda.agdaWithPackages (pkgs: with pkgs; [ial]))
    ];

    buildPhase = ''
      agda test.agda
    '';

    installPhase = ''
      install -D -m555 -T test.agdai $out/test.agdai
    '';
  }
