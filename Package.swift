// swift-tools-version: 5.10
// fresco-connect-swift's Package.swift is GENERATED from
// fresco-connect-ios/dist/Package.swift.template by scripts/render-manifest.sh. Edit the template,
// never the generated file — the next publish overwrites it. The version and the checksum must
// always describe the same artifact, so they are written together or not at all, and every
// dependency range is filled from fresco-connect-ios's own Package.swift, so the manifest cannot
// disagree with what the artifact was built against.
//
// A deliberately low tools version: a partner on an older Xcode can still resolve this package, and
// nothing here needs a newer manifest API. The iOS floor is the FrescoConnectKit framework's, not
// this file's.
import PackageDescription

let package = Package(
  name: "fresco-connect-swift",
  // NFR1. Higher than fresco-recipe-edit-swift's 16.4, which is allowed in this direction only: a
  // consumer of this package must be on iOS 17, while RecipeEdit's own consumers need not be.
  platforms: [.iOS(.v17)],
  products: [
    // The product points at the WRAPPER, not at the binary target. A binaryTarget cannot declare
    // dependencies, so without the wrapper a consumer would link FrescoConnectKit.framework and
    // neither of the two frameworks it needs at load time.
    //
    // The product is named for the MODULE — `FrescoConnectKit` — because that is what a partner
    // imports. The public entry type inside it is `FrescoConnect`; a type may not share its
    // module's name under library evolution (spec DL-16).
    .library(name: "FrescoConnectKit", targets: ["FrescoConnectKitWrapper"])
  ],
  dependencies: [
    // Pantry is NOT named here, and that is deliberate: it arrives through
    // fresco-recipe-edit-swift's own wrapper. A second path to it from this manifest would be
    // harmless today and a resolution conflict the moment the two ranges disagree (spec §10).
    //
    // Ranges, not exact pins: a partner may depend on this package AND on fresco-recipe-edit-swift
    // directly, and SwiftPM fails a graph whose two paths to one identity disagree.
    .package(url: "https://github.com/dropkitchen/fresco-recipe-edit-swift", "1.1.0" ..< "2.0.0"),
    // This range is not a free choice: it must be one the resolved RecipeEdit also accepts, so it
    // matches the KitchenOS range fresco-recipe-edit-swift declares. The two move together, never
    // one alone (spec §10).
    .package(url: "https://github.com/dropkitchen/kitchenos-client-sdk-swift", "2.5.0" ..< "3.0.0")
  ],
  targets: [
    .binaryTarget(
      name: "FrescoConnectKit",
      url: "https://github.com/dropkitchen/fresco-connect-swift/releases/download/v1.1.0/FrescoConnectKit.xcframework.zip",
      checksum: "fabf811825b7786df51b8f18962b251b0cf42d53d862067f14f4a761354c351b"
    ),
    .target(
      name: "FrescoConnectKitWrapper",
      dependencies: [
        "FrescoConnectKit",
        .product(name: "RecipeEdit", package: "fresco-recipe-edit-swift"),
        .product(name: "KitchenOS", package: "kitchenos-client-sdk-swift")
      ],
      path: "Sources/Wrapper"
    )
  ]
)
