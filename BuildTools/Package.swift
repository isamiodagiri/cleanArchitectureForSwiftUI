// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BuildTools",
    products: [
        .library(
            name: "BuildTools",
            targets: ["BuildTools"]),
    ],
    dependencies: [
         .package(url: "https://github.com/uber/mockolo.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "BuildTools",
            dependencies: [
                
            ],
            plugins: [
                .plugin(name: "mockolo", package: "Mockolo")
            ]),
        .testTarget(
            name: "BuildToolsTests",
            dependencies: ["BuildTools"]),
    ]
)
