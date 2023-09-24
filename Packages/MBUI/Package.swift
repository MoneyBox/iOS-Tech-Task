// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "MBUI",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MBUI",
            targets: ["MBUI"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MBUI",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "MBUITests",
            dependencies: ["MBUI"]
        )
    ]
)
