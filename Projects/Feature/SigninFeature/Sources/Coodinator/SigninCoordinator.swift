import FeatureFoundation
import SigninFeatureInterface
import RxSwift
import UIKit

public final class SigninCoordinator: BaseCoordinator<SigninRoutePath> {
  
  private let signinViewController: SigninViewController

  init(viewController: SigninViewController) {
    signinViewController = viewController
    super.init()
  }

  override public var rootViewController: UIViewController {
    signinViewController
  }

  override public func start() {
    signinViewController.routes
      .bind(to: routes)
      .disposed(by: disposeBag)
  }
}
