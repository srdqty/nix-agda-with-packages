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
    name = "test-agda-stdlib";

    src = ./.;

    buildInputs = [
      (agda.agdaWithPackages (pkgs: with pkgs; [agda-stdlib]))
    ];

    buildPhase = ''
      agda --compile hello.agda
    '';

    installPhase = ''
      install -D -m555 -T hello $out/bin/hello
    '';
  }
