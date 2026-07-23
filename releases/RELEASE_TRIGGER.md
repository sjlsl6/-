# Release trigger

The verified Windows release workflow can be started manually with GitHub Actions `workflow_dispatch`, or by opening an issue whose title is exactly:

`Publish Windows release v2026.07.24`

The workflow verifies all three executable SHA-256 values before publishing any GitHub Release assets.
