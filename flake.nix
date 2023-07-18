{
  inputs = {
    nixpkgs.url = "github:/nixos/nixpkgs/nixpkgs-unstable";
    n2c = {
      url = "github:nlewo/nix2container";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    srv = {
      url = "github:input-output-hk/offchain-metadata-tools?ref=refs/pull/57/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { n2c, srv, nixpkgs, ... }: let
    inherit (n2c.packages.x86_64-linux.nix2container) buildLayer buildImage;
    inherit (nixpkgs.legacyPackages.x86_64-linux) writeScript;

    package = srv.x86_64-linux.app.packages.metadata-sync;
  in rec {
     entrypoint-layer = buildLayer {
       deps = [package];
       maxLayers = 50;
       reproducible = true;
     };
     # wrapper needed for `.copyTo` commands
     # but not part of the bug stack
     image = buildImage {
       name = "image";
       tag = "tag";
       layers = [entrypoint-layer];
     };
  };
}
