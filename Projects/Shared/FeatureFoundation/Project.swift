import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: Module.Shared.FeatureFoundation.rawValue,
  targets: [
    // MARK: - Implement

    .implement(
      module: .shared(.FeatureFoundation),
      dependencies: [
        .shared(target: .DesignSystem),
        .shared(target: .ThirdPartyLibrary),
      ],
    )
  ],
)
