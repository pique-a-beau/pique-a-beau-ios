import UIKit

// MARK: - Router

public protocol Router {
  func setRoot(_ viewController: UIViewController, animated: Bool)
  func push(_ viewController: UIViewController, animated: Bool)
  func present(_ viewController: UIViewController, animated: Bool)
  func pop(animated: Bool)
  func dismiss(animated: Bool)
}

// MARK: - NavigationRouter

public final class NavigationRouter: Router {

  // MARK: Lifecycle

  public init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  // MARK: Public

  public let navigationController: UINavigationController

  public func setRoot(_ viewController: UIViewController, animated: Bool) {
    navigationController.setViewControllers([viewController], animated: animated)
  }

  public func push(_ viewController: UIViewController, animated: Bool) {
    navigationController.pushViewController(viewController, animated: animated)
  }

  public func present(_ viewController: UIViewController, animated: Bool) {
    navigationController.present(viewController, animated: animated)
  }

  public func pop(animated: Bool) {
    navigationController.popViewController(animated: animated)
  }

  public func dismiss(animated: Bool) {
    navigationController.dismiss(animated: animated)
  }
}
