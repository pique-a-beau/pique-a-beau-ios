import FeatureFoundation
import OnboardingFeatureInterface
import RxSwift
import UIKit

public final class OnboardingCoordinator: BaseCoordinator<OnboardingRoutePath> {

  private let router: Router
  private let onboardingViewController: OnboardingViewController

  init(
    router: Router,
    viewController: OnboardingViewController
  ) {
    self.router = router
    onboardingViewController = viewController
    super.init()
  }

  override public var rootViewController: UIViewController {
    onboardingViewController
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
