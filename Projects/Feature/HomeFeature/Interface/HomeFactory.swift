import FeatureFoundation
import UIKit

public enum HomeRoutePath: RoutePath {

}

public protocol HomeFactory: Factory {
  func makeCoordinator(navigationController: UINavigationController) -> BaseCoordinator<HomeRoutePath>
}
