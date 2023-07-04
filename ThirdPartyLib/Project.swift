import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "ThirdPartyLib",
    packages: [
        .RxSwift,
        .Realm,
        .Moya,
        .Then,
        .SnapKit,
        .Kingfisher
    ],
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    dependencies: [
        .SPM.RxSwift,
        .SPM.Realm,
        .SPM.RealmSwift,
        .SPM.RxCocoa,
        .SPM.RxMoya,
        .SPM.Then,
        .SPM.SnapKit,
        .SPM.Kingfisher
    ]
)
