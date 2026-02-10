import FeatureFoundation
import Foundation
import HomeFeatureInterface
import UIKit

public struct DefaultHomeFactory: HomeFactory {
  
  public init() {}

  public func makeCoordinator(navigationController: UINavigationController) -> BaseCoordinator<HomeRoutePath> {
    let router = NavigationRouter(navigationController: navigationController)
    let viewModel = HomeViewModel()
    let viewController = HomeViewController(viewModel: viewModel)
    
    return HomeCoordinator(
      navigationController: navigationController,
      router: router,
      viewController: viewController
    )
  }
}
