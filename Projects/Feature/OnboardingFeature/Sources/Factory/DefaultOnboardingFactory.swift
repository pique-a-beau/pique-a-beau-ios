import FeatureFoundation
import Foundation
import OnboardingFeatureInterface
import UIKit

public struct DefaultOnboardingFactory: OnboardingFactory {
  
  public init() {}

  public func makeCoordinator(navigationController: UINavigationController) -> BaseCoordinator<OnboardingRoutePath> {
    let router = NavigationRouter(navigationController: navigationController)
    let viewModel = OnboardingViewModel()
    let viewController = OnboardingViewController(viewModel: viewModel)
    
    return OnboardingCoordinator(
      navigationController: navigationController,
      router: router,
      viewController: viewController
    )
  }
}
