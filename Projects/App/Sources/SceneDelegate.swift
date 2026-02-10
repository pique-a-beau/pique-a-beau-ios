import FeatureFoundation
import RootFeature
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  // MARK: Internal

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }

    let window = UIWindow(windowScene: scene)
    guard
      let rootCoordinator = AppDelegate
        .container
        .resolve(
          RootCoordinator.self,
          argument: window,
        )
    else { return }

    rootCoordinator.start()
    self.rootCoordinator = rootCoordinator
    self.window = window
  }

  // MARK: Private

  private var rootCoordinator: RootCoordinator?

}
