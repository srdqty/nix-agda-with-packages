{ Agda
, fetchgit
, ghcBuild
, stdenv
}:

stdenv.mkDerivation rec {
  name = "agda-stdlib-${version}";
  version = builtins.substring 0 7 src.rev;

  src = fetchgit {
    url = "https://github.com/agda/agda-stdlib";
    rev = "076fd0fec297ef0fd30cb135a4516efd1fbdaafe";
    sha256 = "1wd7f1fg93h39bb4x1gfbx86158l8fx1xpngzqzkws162y6sxcdc";
  };

  buildInputs = [
    Agda
    ghcBuild
  ];

  buildPhase = ''
    runhaskell GenerateEverything.hs
    agda -i . -i src Everything.agda
    agda -i . -i src EverythingSafe.agda
    agda -i . -i src EverythingSafeGuardedness.agda
    agda -i . -i src EverythingSafeSizedTypes.agda
    agda -i . -i src README.agda
  '';

  installPhase = ''
    mkdir -p $out/libs
    find . -regex '.*\.l?agdai?' -exec cp --parents '{}' $out/libs \;
  '';
}
