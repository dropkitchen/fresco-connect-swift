# Fresco Connect for iOS

Fresco Connect embeds the Fresco cooking experience in your app. One dependency, one import.

> **Pre-release.** No version is published yet. This repository holds the manifest and the release
> assets; the first tag will be `v0.0.1`, a **walking skeleton** that renders a placeholder screen
> and opens no editor. `FrescoConnectInfo.isStub` is `true` in it, and will be `false` in the first
> release that edits recipes.

## Requirements

| | |
|---|---|
| iOS | 17.0 or later |
| Xcode | 26.0 or later |
| Swift | any — the framework ships with library evolution enabled, so your Swift version need not match ours |

The iOS simulator slice is **arm64 only**. You can build for a device from any Mac, and for the
simulator from an Apple-silicon Mac. Building for the simulator on an Intel Mac is not supported —
the KitchenOS SDK underneath stopped publishing an x86_64 slice.

## Installation

Add the package in Xcode (*File ▸ Add Package Dependencies…*) or in your own `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/dropkitchen/fresco-connect-swift", from: "1.0.0")
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "FrescoConnectKit", package: "fresco-connect-swift")
    ])
]
```

Nothing else is needed. The package brings the frameworks it depends on with it, and your app never
names them.

## Usage

```swift
import FrescoConnectKit

let fresco = FrescoConnect(
    configuration: FrescoConfiguration(
        environment: .production,
        clientId: "the client id Fresco issued you",
        region: "eu-west-1",
        theme: FrescoTheme(
            brandColors: FrescoBrandColors(
                primary: .yourBrandPrimary,
                textEmphasis: .yourBrandTextEmphasis,
                action: .yourBrandAction
            )
        )
    )
)
```

`FrescoConnect(configuration:)` is cheap and does no I/O, so it is safe on your launch path. It is
also callable from any actor; everything that draws is main-actor isolated.

### Why the import is `FrescoConnectKit` and the type is `FrescoConnect`

Swift does not allow a public type to share its module's name — the compiler emits a module
interface that then fails to parse (Swift issue #56573). The type keeps the name you call, and the
module carries the `Kit` suffix. You will only ever see `FrescoConnectKit` in your import line.

## What ships in a release

| Asset | |
|---|---|
| `FrescoConnectKit.xcframework.zip` | device and simulator slices, each with its dSYM |
| `FrescoConnectKit.xcframework.zip.sha256` | the checksum sidecar, matching the manifest |

Both are resolvable anonymously — no token, no credentials.

## Diagnosing a `KitchenOS` conflict

If your build fails with

```
error: multiple packages ('…', '…') declare targets with a conflicting name: 'KitchenOS'
```

your app depends on the **archived** `kitchenos-client-sdk-ios` as well as on this package. SwiftPM
derives package identity from the URL, so the two are different packages declaring the same target.
Point every dependency at `https://github.com/dropkitchen/kitchenos-client-sdk-swift` — with no
`.git` suffix and no SSH form — and the graph resolves to one copy.

## Support

This repository takes no issues or pull requests; it is a publishing channel. Reach your Fresco
contact, and include `FrescoConnectInfo.version` — it reports the artifact you actually resolved.
