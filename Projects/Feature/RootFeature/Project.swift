import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: Module.Feature.RootFeature.rawValue,
    targets: [
        .implement(
            module: .feature(.RootFeature),
            dependencies: [
                .feature(target: .BaseFeature),
                .feature(target: .SigninFeature, type: .interface),
            ]
        ),
    ]
)
