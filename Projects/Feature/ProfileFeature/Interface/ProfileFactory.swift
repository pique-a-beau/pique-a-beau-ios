import FeatureFoundation
import UIKit

public enum ProfileRoutePath: RoutePath {
  
}

public protocol ProfileFactory: Factory {
  func makeCoordinator(navigationController: UINavigationController) -> BaseCoordinator<ProfileRoutePath>
}
