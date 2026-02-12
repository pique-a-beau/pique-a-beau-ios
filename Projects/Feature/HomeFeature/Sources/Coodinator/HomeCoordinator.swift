import FeatureFoundation
import HomeFeatureInterface
import RxSwift
import UIKit

public final class HomeCoordinator: BaseCoordinator<HomeRoutePath> {

  private let router: Router
  private let homeViewController: HomeViewController

  init(
    router: Router,
    viewController: HomeViewController
  ) {
    self.router = router
    homeViewController = viewController
    super.init()
  }

  override public var rootViewController: UIViewController {
    homeViewController
  }

  override public func start() {
    router.setRoot(homeViewController, animated: false)
    
    homeViewController.routes
      .subscribe(onNext: { [weak self] routePath in
        switch routePath {
        case .toDetail:
          break
        }
      })
      .disposed(by: disposeBag)
  }
}
