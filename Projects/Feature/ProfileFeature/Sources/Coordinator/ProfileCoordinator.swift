import FeatureFoundation
import ProfileFeatureInterface
import RxSwift
import UIKit

public final class ProfileCoordinator: BaseCoordinator<ProfileRoutePath> {
  
  private let navigationController: UINavigationController
  private let router: Router
  private let profileViewController: ProfileViewController

  init(
    navigationController: UINavigationController,
    router: Router,
    viewController: ProfileViewController
  ) {
    self.navigationController = navigationController
    self.router = router
    profileViewController = viewController
    super.init()
  }

  override public var rootViewController: UIViewController {
    navigationController
  }

  override public func start() {
    router.setRoot(profileViewController, animated: false)
    
    profileViewController.routes
      .bind(to: routes)
      .disposed(by: disposeBag)
  }
}
