import FeatureFoundation
import Foundation
import SigninFeatureInterface
import UIKit

public struct DefaultSigninFactory: SigninFactory {
  
  public init() {}

  public func makeCoordinator() -> BaseCoordinator<SigninRoutePath> {
    let viewModel = SigninViewModel()
    let viewController = SigninViewController(viewModel: viewModel)
    return SigninCoordinator(viewController: viewController)
  }
}
