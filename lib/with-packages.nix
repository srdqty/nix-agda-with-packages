{ Agda
, agdaPackages
, ghcBackend
, glibcLocales
, makeWrapper
, stdenv
, symlinkJoin
}: pkgsFun:

let
  paths = stdenv.lib.closePropagation (pkgsFun agdaPackages);

  locale-archive = stdenv.lib.optionalString stdenv.isLinux
    "--set LOCALE_ARCHIVE ${glibcLocales}/lib/locale/locale-archive \\";
in

stdenv.lib.appendToName "with-packages" (symlinkJoin {
  inherit (Agda) name;

  paths = paths ++ [ Agda ghcBackend ];

  buildInputs = [ makeWrapper ];

  # TODO: add attribute to derivations so we can extract
  # the directories for the library flags
  postBuild = ''
    wrapProgram $out/bin/agda \
      --add-flags "-i $out/libs -i $out/libs/src" \
      ${locale-archive}
      --set LANG "en_US.UTF-8"
  '';
})