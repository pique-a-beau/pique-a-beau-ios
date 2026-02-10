import FeatureFoundation
import UIKit

public protocol RootFactory {
  func makeCoordinator(window: UIWindow) -> BaseCoordinator
}
