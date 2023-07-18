# Reproduces

```console
❯ nix run .\#image.copyToDockerDaemon
warning: Git tree '/home/blaggacao/src/github.com/input-output-hk/reproduce-multilayer-n2c-issue' is dirty
trace: haskell-nix.haskellLib.cleanGit: /nix/store/xp03wdsi8bhxxj4jq4v9rrq6bb6jhbkk-source does not seem to be a git repository,
assuming it is a clean checkout.
trace: To make project.plan-nix for haskell-project a fixed-output derivation but not materialized, set `plan-sha256` to the output of the 'calculateMaterializedSha' script in 'passthru'.
trace: To materialize project.plan-nix for haskell-project entirely, pass a writable path as the `materialized` argument and run the 'updateMaterialized' script in 'passthru'.
trace: haskell-nix.haskellLib.cleanGit: /nix/store/xp03wdsi8bhxxj4jq4v9rrq6bb6jhbkk-source does not seem to be a git repository,
assuming it is a clean checkout.
trace: To make project.plan-nix for haskell-project a fixed-output derivation but not materialized, set `plan-sha256` to the output of the 'calculateMaterializedSha' script in 'passthru'.
trace: To materialize project.plan-nix for haskell-project entirely, pass a writable path as the `materialized` argument and run the 'updateMaterialized' script in 'passthru'.
Copy to Docker daemon image image:tag
Getting image source signatures
Copying blob 97cdc8904388 done
Copying blob d0174cfae1d5 done
Copying blob fce76c80dacb done
Copying blob be84714da08f done
Copying blob f6c325d04612 done
Copying blob 4d647692e93a done
Copying blob 8bec8b877f64 done
Copying blob b16c1dac0e07 done
Copying blob a818be9e707f done
Copying blob 389fbba1ceb4 done
Copying blob f03474f18eec done
Copying blob 8713eb20b446 done
Copying blob 94fdbee7d398 done
Copying blob e467d3834393 done
Copying blob 0f08b66a767c done
Copying blob fcfbbc9ee303 done
Copying blob d18355b1f67e done
Copying blob 1bbca2005f6b done
Copying blob eecae7b70f6f done
Copying blob 2c742bef65ba done
Copying blob 3a77501ff019 done
Copying blob 6ac923c37e3e done
Copying blob 038634c7a43f done
FATA[0002] writing blob: writing to temporary on-disk layer: happened during read: Digest did not match, expected sha256:6ac923c37e3eb31809119147cc9dfd384f78f999eddea5ccb43f7d7d0a5db320, got sha256:1c0737b3c16c1cb3b4e949c3deb08fb3d813b98eb53f7eb722df3a110fa231f7
```


For more detail, run: `nix run .\#image.copyToDockerDaemon -- --debug`

# Mismatch is consistent

```console
expected sha256:6ac923c37e3eb31809119147cc9dfd384f78f999eddea5ccb43f7d7d0a5db320,
got      sha256:1c0737b3c16c1cb3b4e949c3deb08fb3d813b98eb53f7eb722df3a110fa231f7
```

Running with `--debug` shows that `6ac923...` corresponds to the `package`:
```
DEBU[0001] Checking if we can reuse blob sha256:6ac923c37e3eb31809119147cc9dfd384f78f999eddea5ccb43f7d7d0a5db320: general substitution = true, compression for MIME type "application/vnd.oci.image.layer.v1.tar" = true
DEBU[0001] Walking filesystem: /nix/store/910j1q2lkjm91fyz63d65cd2g51nlfs0-metadata-sync-exe-metadata-sync-0.4.0.0
DEBU[0001] Walking filesystem: /nix/store/910j1q2lkjm91fyz63d65cd2g51nlfs0-metadata-sync-exe-metadata-sync-0.4.0.0/bin
DEBU[0001] Walking filesystem: /nix/store/910j1q2lkjm91fyz63d65cd2g51nlfs0-metadata-sync-exe-metadata-sync-0.4.0.0/bin/metadata-sCopying blob 97cdc8904388 done
```

