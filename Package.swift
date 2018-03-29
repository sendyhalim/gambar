// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Gambar",
  dependencies: [
    .package(url: "https://github.com/Quick/Quick", from: "1.2.0"),
    .package(url: "https://github.com/kylef/Commander", .branch("master")),
    .package(url: "https://github.com/twostraws/SwiftGD.git", .branch("master"))
  ],
  targets: [
    .target(
      name: "Gambar",
      dependencies: ["GambarImage", "Commander"]
    ),
    .target(
      name: "GambarImage",
      dependencies: ["SwiftGD"]
    ),
    .testTarget(
      name: "GambarTests",
      dependencies: ["GambarImage", "Quick", "Nimble"],
      path: "./Tests/"
    )
  ]
)
