// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeedKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "FeedKit", targets: ["FeedKit"]),
    ], 
    dependencies: [ ],
    targets: [
        .target(name: "FeedKit", dependencies: [])
    ]
)
