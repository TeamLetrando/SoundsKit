// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SoundsKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "SoundsKit",
            targets: ["SoundsKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SoundsKit",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "SoundsKitTests",
            dependencies: ["SoundsKit"],
            resources: [.process("Resources/corrupt.pdf"), .process("Resources/test.wav")]),
    ]
)
