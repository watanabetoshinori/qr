// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "qr",
    platforms: [
        .macOS(.v10_13),
    ],
    products: [
        .executable(name: "qr", targets: ["qr"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.5.0")
    ],
    targets: [
        .target(
            name: "qr",
            dependencies: ["SPMUtility"]),
        .testTarget(
            name: "qrTests",
            dependencies: ["qr"]),
    ]
)
