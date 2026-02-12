import FeatureFoundation
import OnboardingFeatureInterface
import RxSwift
import UIKit

public final class OnboardingCoordinator: BaseCoordinator<OnboardingRoutePath> {
  
  private let navigationController: UINavigationController
  private let router: Router
  private let onboardingViewController: OnboardingViewController

  init(
    navigationController: UINavigationController,
    router: Router,
    viewController: OnboardingViewController
  ) {
    self.navigationController = navigationController
    self.router = router
    onboardingViewController = viewController
    super.init()
  }

  override public var rootViewController: UIViewController {
    navigationController
  }

  override public func start() {
    router.setRoot(onboardingViewController, animated: false)
    
    onboardingViewController.routes
      .subscribe(onNext: { [weak self] routePath in
        self?.routes.onNext(routePath)
      })
      .disposed(by: disposeBag)
  }
}
