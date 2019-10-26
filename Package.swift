// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Gambar",
  dependencies: [
    .package(url: "https://github.com/kylef/Commander", .upToNextMajor(from: "0.9.1")),
    .package(url: "https://github.com/Quick/Quick", .upToNextMajor(from: "2.2.0")),
    .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "8.0.4")),
    .package(url: "https://github.com/twostraws/SwiftGD", .upToNextMajor(from: "2.5.0")),
    .package(url: "https://github.com/sendyhalim/Swort", .upToNextMajor(from: "0.0.3"))
  ],
  targets: [
    .target(
      name: "Gambar",
      dependencies: ["GambarImage", "Commander"]
    ),
    .target(
      name: "GambarImage",
      dependencies: ["SwiftGD", "Swort"]
    ),
    .testTarget(
      name: "GambarImageTests",
      dependencies: ["GambarImage", "Quick", "Nimble"],
      path: "./Tests/GambarImageTests"
    )
  ]
)
