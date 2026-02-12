import FeatureFoundation
import UIKit


public protocol HomeFactory: Factory {
  func makeCoordinator(navigationController: UINavigationController) -> BaseCoordinator<HomeRoutePath>
}
