// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Gambar",
  dependencies: [
    .package(url: "https://github.com/kylef/Commander", .branch("master")),
    .package(url: "https://github.com/kylef/Spectre.git", .branch("master")),
    .package(url: "https://github.com/twostraws/SwiftGD.git", .branch("master")),
    .package(url: "https://github.com/typelift/Swiftz", .branch("master")),
    .package(url: "https://github.com/sendyhalim/Swort", from: "0.0.2")
  ],
  targets: [
    .target(
      name: "Gambar",
      dependencies: ["GambarImage", "Commander"]
    ),
    .target(
      name: "GambarImage",
      dependencies: ["SwiftGD", "Swiftz", "Swort"]
    ),
    .testTarget(
      name: "GambarImageTests",
      dependencies: ["GambarImage", "Spectre"],
      path: "./Tests/GambarImageTests"
    )
  ]
)
