import FeatureFoundation
import HomeFeatureInterface
import RxSwift
import UIKit

public final class HomeCoordinator: BaseCoordinator<HomeRoutePath> {
  
  private let navigationController: UINavigationController
  private let router: Router
  private let homeViewController: HomeViewController

  init(
    navigationController: UINavigationController,
    router: Router,
    viewController: HomeViewController
  ) {
    self.navigationController = navigationController
    self.router = router
    homeViewController = viewController
    super.init()
  }

  override public var rootViewController: UIViewController {
    navigationController
  }

  override public func start() {
    router.setRoot(homeViewController, animated: false)
    
    homeViewController.routes
      .bind(to: routes)
      .disposed(by: disposeBag)
  }
}
