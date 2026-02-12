import FeatureFoundation
import UIKit

public enum OnboardingRoutePath: RoutePath {
  case completeOnboarding
}

public protocol OnboardingFactory: Factory {
  func makeCoordinator(navigationController: UINavigationController) -> BaseCoordinator<OnboardingRoutePath>
}
