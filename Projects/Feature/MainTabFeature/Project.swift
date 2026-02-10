import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: Module.Feature.MainTabFeature.rawValue,
  targets: [
    .interface(
      module: .feature(.MainTabFeature),
      dependencies: [
        .shared(target: .FeatureFoundation)
      ],
    ),
    .implement(
      module: .feature(.MainTabFeature),
      dependencies: [
        .feature(target: .MainTabFeature, type: .interface),
        .feature(target: .HomeFeature, type: .interface),
        .feature(target: .ProfileFeature, type: .interface),
        .shared(target: .FeatureFoundation),
      ],
    ),
  ],
)
