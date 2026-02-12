import DependencyPlugin
import EnvironmentPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: Module.Feature.HomeFeature.rawValue,
  targets: [
    .target(
      name: Module.Feature.HomeFeature.targetName(type: .demo),
      destinations: environment.destination,
      product: .app,
      bundleId: "\(environment.organizationName).\(Module.Feature.HomeFeature.rawValue.lowercased()).demo",
      deploymentTargets: environment.deploymentTargets,
      infoPlist: .extendingDefault(with: [
        "UILaunchStoryboardName": "LaunchScreen",
        "CFBundleVersion": "1.0",
        "UIApplicationSceneManifest": [
          "UIApplicationSupportsMultipleScenes": false,
          "UISceneConfigurations": [
            "UIWindowSceneSessionRoleApplication": [
              [
                "UISceneConfigurationName": "Default Configuration",
                "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
              ]
            ]
          ]
        ]
      ]),
      sources: ["Demo/Sources/**"],
      resources: ["Demo/Resources/**"],
      dependencies: [
        .feature(target: .HomeFeature)
      ]
    ),
    .tests(
      module: .feature(.HomeFeature),
      dependencies: [
        .feature(target: .HomeFeature),
        .feature(target: .HomeFeature, type: .testing),
      ],
    ),
    .implement(
      module: .feature(.HomeFeature),
      dependencies: [
        .feature(target: .HomeFeature, type: .interface)
      ],
    ),
    .testing(
      module: .feature(.HomeFeature),
      dependencies: [
        .feature(target: .HomeFeature, type: .interface)
      ],
    ),
    .interface(
      module: .feature(.HomeFeature),
      dependencies: [
        .shared(target: .ThirdPartyLibrary),
        .shared(target: .FeatureFoundation),
      ],
    ),
  ],
)
