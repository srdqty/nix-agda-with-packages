{ Agda
, fetchgit
, stdenv
}:

stdenv.mkDerivation rec {
  name = "iowa-agda-library-${version}";
  version = builtins.substring 0 7 src.rev;

  src = fetchgit {
    url = "https://github.com/srdqty/ial";
    rev = "4d1fceb8c057683d0ae27ee624ea98a26dea5bc5";
    sha256 = "07mbrd4kdd6ac4sbym6jw95v2z0zzaj9xc19r7cq39dmx8nb6ia9";
  };

  buildInputs = [
    Agda
  ];

  buildPhase = ''
    patchShebangs find-deps.sh
    make
  '';

  installPhase = ''
    mkdir -p $out/libs
    find . -regex '.*\.l?agdai?' -exec cp --parents '{}' $out/libs \;
  '';
}
