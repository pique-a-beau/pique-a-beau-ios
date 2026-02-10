import FeatureFoundation
import Foundation
import ProfileFeatureInterface
import UIKit

public struct DefaultProfileFactory: ProfileFactory {
  
  public init() {}

  public func makeCoordinator(navigationController: UINavigationController) -> BaseCoordinator<ProfileRoutePath> {
    let router = NavigationRouter(navigationController: navigationController)
    let viewModel = ProfileViewModel()
    let viewController = ProfileViewController(viewModel: viewModel)
    
    return ProfileCoordinator(
      navigationController: navigationController,
      router: router,
      viewController: viewController
    )
  }
}
