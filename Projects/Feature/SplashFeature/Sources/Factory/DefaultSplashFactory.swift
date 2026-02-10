import FeatureFoundation
import Foundation
import SplashFeatureInterface
import UIKit

public struct DefaultSplashFactory: SplashFactory {
  
  public init() {}

  public func makeCoordinator() -> BaseCoordinator<SplashRoutePath> {
    let viewModel = SplashViewModel()
    let viewController = SplashViewController(viewModel: viewModel)
    return SplashCoordinator(viewController: viewController)
  }
}
