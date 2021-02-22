// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "LocalizedNumberField",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "LocalizedNumberField",
                 targets: ["LocalizedNumberField"])
    ],
    targets: [
        .target(name: "LocalizedNumberField",
                path: "LocalizedNumberField")
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
