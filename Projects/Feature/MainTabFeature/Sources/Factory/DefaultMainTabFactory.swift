import FeatureFoundation
import HomeFeatureInterface
import MainTabFeatureInterface
import ProfileFeatureInterface
import UIKit

public struct DefaultMainTabFactory: MainTabFactory {
  
  private let homeFactory: HomeFactory
  private let profileFactory: ProfileFactory

  public init(
    homeFactory: HomeFactory,
    profileFactory: ProfileFactory
  ) {
    self.homeFactory = homeFactory
    self.profileFactory = profileFactory
  }

  public func makeCoordinator() -> BaseCoordinator<MainTabRoutePath> {
    let viewModel = MainTabViewModel()
    let tabBarController = MainTabBarController(viewModel: viewModel)
    
    return MainTabCoordinator(
      tabBarController: tabBarController,
      homeFactory: homeFactory,
      profileFactory: profileFactory
    )
  }
}
