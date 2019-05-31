{ compiler }:
let
  haskellOverlay = (self: super: let hlib = super.haskell.lib; in {
    haskellPackages = super.haskell.packages."${compiler}".override {
      overrides = (new: old: {
      });
    };
  });

  nonHaskellOverlay = (self: super: {
  });
in
  [nonHaskellOverlay haskellOverlay]
