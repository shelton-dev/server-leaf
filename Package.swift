// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "leaf",
    platforms: [
       .macOS(.v11),
       .iOS(.v13)
    ],
    products: [
        .library(name: "Leaf", targets: ["Leaf"]),
    ],
    dependencies: [
        .package(path: "../Leaf-Kit"),
        .package(url: "git@github.com:vapor/vapor.git", from: "4.0.0"),
    ],
    targets: [
        .target(name: "Leaf", dependencies: [
            .product(name: "leaf-kit", package: "Leaf-Kit"),
            .product(name: "Vapor", package: "vapor"),
        ]),
        .testTarget(name: "LeafTests", dependencies: [
            .target(name: "Leaf"),
            .product(name: "XCTVapor", package: "vapor"),
        ]),
    ]
)
