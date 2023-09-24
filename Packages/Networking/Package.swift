// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "API",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Networking",
            dependencies: []
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        )
    ]
)
