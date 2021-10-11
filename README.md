## SoundsKit

[![SPM ready](https://img.shields.io/badge/SPM-ready-orange.svg)](https://swift.org/package-manager/)


## Overview
SoundsKit is a simple library that lets you deal with Swift sounds easily.

##### Creating instances of *SoundsKit* class

Specify a file for your sound manager:

```swift
SoundsKit.file
```

Specify a extension file for your sound manager. The default value is `mp3`:

```swift
SoundsKit.fileExtension
```

Creating an instance has more benefits in managing your app sounds.

##### Static methods

```swift
SoundsKit.play()
```

Stop currently playing sound:

```swift
SoundsKit.stop()
```

CPlay speech in any language. The default value is "pt-BR".

```swift
SoundsKit.reproduceSpeech(_ text: String, language: String)
```

Enable/disable sound:

```swift
SoundsKit.setKeyAudio(true)
SoundsKit.setKeyAudio(false)
```

The value of `SoundsKit.setKeyAudio(_ key: Bool)` property will be automatically persisted in `UserDefaults` and restored on the next launch of your app.

Check enable/disable sound:

```swift
SoundsKit.audioIsOn()
```

## Features
- [x] Ability to pause and resume
- [x] Adjusting sound volume


## Requirements
- Swift 5
- iOS 13.0 or later

## Installation

### Installation with Swift Package Manager

The Swift Package Manager is a tool for managing the distribution of Swift code. Just add the url of this repo to your `Package.swift` file as a dependency:

```swift
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
            dependencies: []),
        .testTarget(
            name: "SoundsKitTests",
            dependencies: ["SoundsKit"],
            resources: [.process("Resources/corrupt.pdf"), .process("Resources/test.wav")]),
    ]
)
```

Then run `swift build` and wait for SPM to install SoundsKit.

### Manual installation
Drop the `SoundsKit.swift` file into your project, link against `AVFoundation.framework` and you are ready to go.

## Licenses

SoundsKit is licensed under the [MIT License](https://raw.githubusercontent.com/adamcichy/SoundsKit/master/LICENSE).
