// swift-tools-version:5.3
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
            path: "Sources",
            resources: [.process("SoundsKit/Resources/onboarding0.wav"),.process("SoundsKit/Resources/onboarding1.wav"),
                        .process("SoundsKit/Resources/onboarding2.wav"), .process("SoundsKit/Resources/Curious_Kiddo.mp3")]),
        .testTarget(
            name: "SoundsKitTests",
            dependencies: ["SoundsKit"],
            resources: [.process("Resources/corrupt.pdf"), .process("Resources/test.wav")]),
    ]
)
