# Changelog

All notable changes to the published `FrescoConnectKit` artifact.

Versions are semver, tagged on this repository as `vX.Y.Z`. **Below 1.0.0 the breaking boundary is
the MINOR version**, so declare a narrow range — `"0.1.0" ..< "0.2.0"` — rather than `from:`.
SwiftPM does not special-case `0.x`: `from: "0.1.0"` admits `0.9.9`.

## Unreleased

Nothing published yet. `v0.0.1` will be the Phase A walking skeleton: it renders a placeholder
screen, reports `FrescoConnectInfo.isStub == true`, and exists to prove the delivery path — anonymous
resolution, the export boundary, the cascade into RecipeEdit and KitchenOS, and the resource bundle —
while the payload is deliberately trivial.
