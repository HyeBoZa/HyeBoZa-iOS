import ProjectDescriptionHelpers
import ProjectDescription

let project = Project.excutable(
    name: "HyeBoZa-iOS",
    platform: .iOS,
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    dependencies: []
)
