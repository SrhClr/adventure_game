// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "adventure_game",
    products: [
        .executable(name: "adventure_game", targets: ["adventure_game"]),
    ],
    targets: [
        .executableTarget(
            name: "adventure_game",
            dependencies: [],
            resources: [
                .copy("monde.json"),
                .copy("Objets.json")
            ]
        )
    ]
)