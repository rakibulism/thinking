// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PulseClip",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "PulseClip", targets: ["App"])
    ],
    targets: [
        .executableTarget(
            name: "App",
            path: "Sources/App"
        ),
    ]
)
