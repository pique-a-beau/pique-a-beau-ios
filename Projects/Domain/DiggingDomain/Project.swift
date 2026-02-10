import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: Module.Domain.DiggingDomain.rawValue,
  targets: [
    .interface(module: .domain(.DiggingDomain), dependencies: []),
    .implement(module: .domain(.DiggingDomain), dependencies: []),
  ],
)
