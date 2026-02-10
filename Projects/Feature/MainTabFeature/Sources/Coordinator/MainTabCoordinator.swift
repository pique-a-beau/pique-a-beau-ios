import FeatureFoundation
import MainTabFeatureInterface
import HomeFeatureInterface
import ProfileFeatureInterface
import RxSwift
import UIKit

public final class MainTabCoordinator: BaseCoordinator<MainTabRoutePath> {
  
  private let tabBarController: MainTabBarController
  private let homeFactory: HomeFactory
  private let profileFactory: ProfileFactory

  public init(
    tabBarController: MainTabBarController,
    homeFactory: HomeFactory,
    profileFactory: ProfileFactory
  ) {
    self.tabBarController = tabBarController
    self.homeFactory = homeFactory
    self.profileFactory = profileFactory
    super.init()
  }

  override public var rootViewController: UIViewController {
    tabBarController
  }

  override public func start() {
    setupTabCoordinators()
    
    tabBarController.routes
      .bind(to: routes)
      .disposed(by: disposeBag)
  }

  private func setupTabCoordinators() {
    let homeNavigationController = UINavigationController()
    let homeCoordinator = homeFactory.makeCoordinator(navigationController: homeNavigationController)

    homeCoordinator.rootViewController.tabBarItem = UITabBarItem(
      title: "홈",
      image: UIImage(systemName: "home"),
      selectedImage: UIImage(systemName: "home.fill")
    )

    addChild(homeCoordinator)
    homeCoordinator.start()

    let profileNavigationController = UINavigationController()
    let profileCoordinator = profileFactory.makeCoordinator(navigationController: profileNavigationController)

    profileCoordinator.rootViewController.tabBarItem = UITabBarItem(
      title: "프로필",
      image: UIImage(systemName: "person"),
      selectedImage: UIImage(systemName: "person.fill")
    )

    addChild(profileCoordinator)
    profileCoordinator.start()

    tabBarController.viewControllers = [
      homeCoordinator.rootViewController,
      profileCoordinator.rootViewController,
    ]
  }
}
