import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: Module.Feature.RootFeature.rawValue,
  targets: [
    .implement(
      module: .feature(.RootFeature),
      dependencies: [
        .feature(target: .SplashFeature),
        .feature(target: .MainTabFeature),
        .feature(target: .MainTabFeature, type: .interface),
        .feature(target: .HomeFeature),
        .feature(target: .ProfileFeature),
        .feature(target: .SigninFeature, type: .interface),
        .shared(target: .FeatureFoundation),
      ],
    )
  ],
)
