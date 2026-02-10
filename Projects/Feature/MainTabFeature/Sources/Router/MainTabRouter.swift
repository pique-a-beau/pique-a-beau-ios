import FeatureFoundation
import UIKit

// MARK: - MainTabRouting

public protocol MainTabRouting {
  var tabBarController: UITabBarController { get }

  func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
  func selectTab(at index: Int)
}

// MARK: - MainTabRouter

public final class MainTabRouter: MainTabRouting {

  // MARK: Lifecycle

  public init(tabBarController: UITabBarController) {
    self.tabBarController = tabBarController
  }

  // MARK: Public

  public let tabBarController: UITabBarController

  public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
    tabBarController.setViewControllers(viewControllers, animated: animated)
  }

  public func selectTab(at index: Int) {
    guard index < (tabBarController.viewControllers?.count ?? 0) else { return }
    tabBarController.selectedIndex = index
  }
}
