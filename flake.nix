{
  inputs = {
    # nixpkgs.url = "github:/nixos/nixpkgs/8e3b64db39f2aaa14b35ee5376bd6a2e707cadc2";
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
    inherit (nixpkgs.legacyPackages.x86_64-linux) gitMinimal writeScript;

    package = srv.x86_64-linux.app.packages.metadata-sync;
    entrypoint = writeScript "entrypoint" ''
      ${gitMinimal}
      ${package}
    '';
  in rec {
     runtime-layer = buildLayer {
       deps = [gitMinimal]; # is also in entrypoint script
       maxLayers = 10;
       reproducible = true;
     };
     entrypoint-layer = buildLayer {
       deps = [entrypoint];
       maxLayers = 50;
       reproducible = true;
       layers = [runtime-layer]; # commenting out this line heals the digest
     };
     # wrapper needed for `.copyTo` commands
     # but not part of the bug stack
     image = buildImage {
       name = "image";
       tag = "tag";
       layers = [entrypoint-layer];
       maxLayers = 25;
     };
  };
}
