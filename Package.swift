// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SwiftyNet",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SwiftyNet",
            targets: ["SwiftyNet"]
        ),
    ],
    dependencies: [
        // Add any external dependencies here if needed
    ],
    targets: [
        .target(
            name: "SwiftyNet",
            dependencies: [],
            path: "SwiftyNet/SwiftyNet/Sources"
        ),
        .testTarget(
            name: "SwiftyNetTests",
            dependencies: ["SwiftyNet"],
            path: "SwiftyNet/SwiftyNetTests"
        )
    ],
    swiftLanguageVersions: [.v5]
) 