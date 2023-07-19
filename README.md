# Reproducer
```console
# start clean
❯ nix store delete /nix/store/v2m6npmx9gfwrdzynw8jfj4zfdd1cvwa-layers.json
❯ nix build -L github:input-output-hk/reproduce-multilayer-n2c-issue#entrypoint-layer --no-link
layers.json> INFO[0000] Adding 1 paths to layer (size:1638912 digest:sha256:97cdc89043886124e00b5445e65a67670a0ef1c5a6194e2d9cdb4be0828a2bb8)
[ ... ]
layers.json> INFO[0000] Adding 1 paths to layer (size:5609472 digest:sha256:1c0737b3c16c1cb3b4e949c3deb08fb3d813b98eb53f7eb722df3a110fa231f7)
layers.json> INFO[0000] Layers have been written to /nix/store/v2m6npmx9gfwrdzynw8jfj4zfdd1cvwa-layers.json/layers.json
❯ jq '.[].digest' /nix/store/v2m6npmx9gfwrdzynw8jfj4zfdd1cvwa-layers.json/layers.json | tail -n2
"sha256:3a77501ff019b55b58e2d6f77ea88d3395b0f97503f13d0527f5315ba693b557"
"sha256:1c0737b3c16c1cb3b4e949c3deb08fb3d813b98eb53f7eb722df3a110fa231f7"

# clean locally again
❯ nix store delete /nix/store/v2m6npmx9gfwrdzynw8jfj4zfdd1cvwa-layers.json
❯ nix build -L github:input-output-hk/reproduce-multilayer-n2c-issue#entrypoint-layer --builders ssh://eu.nixbuild.net --no-link
❯ jq '.[].digest' /nix/store/v2m6npmx9gfwrdzynw8jfj4zfdd1cvwa-layers.json/layers.json | tail -n2
"sha256:3a77501ff019b55b58e2d6f77ea88d3395b0f97503f13d0527f5315ba693b557"
"sha256:6ac923c37e3eb31809119147cc9dfd384f78f999eddea5ccb43f7d7d0a5db320"

# QED: sha mismatch
# Can then be better shown by the error message with --rebuild flag:
❯ nix build -L github:input-output-hk/reproduce-multilayer-n2c-issue#entrypoint-layer --builders ssh://eu.nixbuild.net --no-link --rebuild
layers.json> INFO[0000] Adding 1 paths to layer (size:1638912 digest:sha256:97cdc89043886124e00b5445e65a67670a0ef1c5a6194e2d9cdb4be0828a2bb8)
[ ... ]
layers.json> INFO[0000] Adding 1 paths to layer (size:5609472 digest:sha256:1c0737b3c16c1cb3b4e949c3deb08fb3d813b98eb53f7eb722df3a110fa231f7)
layers.json> INFO[0000] Layers have been written to /nix/store/v2m6npmx9gfwrdzynw8jfj4zfdd1cvwa-layers.json/layers.json
error: derivation '/nix/store/hjjs4dsmqrppmr814y8l7ngp6z0ydv7r-layers.json.drv' may not be deterministic: output '/nix/store/v2m6npmx9gfwrdzynw8jfj4zfdd1cvwa-layers.json' differs
```
