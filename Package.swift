// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FutureVision",
    platforms: [
        .macOS(.v14)
    ],
    targets: [
        .executableTarget(
            name: "App",
            path: "Sources/App"
        ),
    ]
)
