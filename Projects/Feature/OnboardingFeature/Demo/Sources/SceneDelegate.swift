import FeatureFoundation
import OnboardingFeature
import OnboardingFeatureInterface
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  private var coordinator: BaseCoordinator<OnboardingRoutePath>?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let window = UIWindow(windowScene: windowScene)
    self.window = window
    
    // Setup Coordinator
    let navigationController = UINavigationController()
    let factory = DefaultOnboardingFactory()
    let coordinator = factory.makeCoordinator(navigationController: navigationController)
    
    coordinator.routes
      .subscribe(onNext: { routePath in
        switch routePath {
        case .completeOnboarding:
          print("✅ Onboarding completed!")
        }
      })
      .disposed(by: coordinator.disposeBag)
    
    coordinator.start()
    self.coordinator = coordinator
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
  }
  
  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
  }
  
  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
  }
  
  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
  }
}
