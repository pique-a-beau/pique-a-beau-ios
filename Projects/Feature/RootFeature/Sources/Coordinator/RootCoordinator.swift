import FeatureFoundation
import MainTabFeatureInterface
import SplashFeatureInterface
import UIKit

// MARK: - RootCoordinator

public final class RootCoordinator: BaseCoordinator<RootRoutePath> {

  // MARK: Lifecycle

  public init(
    window: UIWindow,
    splashFactory: SplashFactory,
    mainTabFactory: MainTabFactory
  ) {
    self.window = window
    self.splashFactory = splashFactory
    self.mainTabFactory = mainTabFactory
    super.init()
    self.window.makeKeyAndVisible()
  }

  // MARK: Public

  override public var rootViewController: UIViewController {
    window.rootViewController ?? UIViewController()
  }

  override public func start() {
    startSplashFlow()
  }

  public func startMainTabFlow() {
    let mainTabCoordinator = mainTabFactory.makeCoordinator()
    addChild(mainTabCoordinator)
    mainTabCoordinator.start()
    setRootViewController(to: mainTabCoordinator.rootViewController)
  }

  public func startToSignInFlow() {
    // TODO: Implement SignIn flow
  }

  // MARK: Private

  private let window: UIWindow
  private let splashFactory: SplashFactory
  private let mainTabFactory: MainTabFactory

  private func startSplashFlow() {
    let splashCoordinator = splashFactory.makeCoordinator()
    addChild(splashCoordinator)
    splashCoordinator.routes
      .subscribe(onNext: { [weak self] route in
        switch route {
        case .mainTab:
          self?.startMainTabFlow()
        case .login:
          self?.startToSignInFlow()
        }
      })
      .disposed(by: disposeBag)
    splashCoordinator.start()
    setRootViewController(to: splashCoordinator.rootViewController)
  }

  private func handleSplashRoute() {

  }

}

extension RootCoordinator {
  private func setRootViewController(to viewController: UIViewController) {
    UIView.transition(
      with: window,
      duration: 0.3,
      options: .transitionCrossDissolve,
    ) {
      self.window.rootViewController = viewController
    }
  }
}
