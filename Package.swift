// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "qr",
    platforms: [
        .macOS(.v11),
    ],
    products: [
        .executable(name: "qr", targets: ["qr"]),
    ],
    dependencies: [
        .package(name: "SwiftPM", url: "https://github.com/apple/swift-package-manager.git", .branch("release/5.7")),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .branch("release/1.0.3"))
    ],
    targets: [
        .executableTarget(
            name: "qr",
            dependencies: [
                "SwiftPM",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .testTarget(
            name: "qrTests",
            dependencies: ["qr"]),
    ]
)
