import FeatureFoundation
import UIKit

public protocol SplashFactory {
  func makeCoordinator() -> BaseCoordinator<SplashRoutePath>
}
