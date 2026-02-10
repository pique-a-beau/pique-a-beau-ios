import FeatureFoundation
import RxSwift
import SplashFeatureInterface
import UIKit

public final class SplashCoordinator: BaseCoordinator<SplashRoutePath> {
  
  private let splashViewController: SplashViewController

  init(viewController: SplashViewController) {
    splashViewController = viewController
    super.init()
  }

  override public var rootViewController: UIViewController {
    splashViewController
  }

  override public func start() {
    splashViewController.routes
      .bind(to: routes)
      .disposed(by: disposeBag)
  }
}
