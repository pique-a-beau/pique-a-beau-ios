import FeatureFoundation

public enum MainTabRoutePath: RoutePath {
  
}

public protocol MainTabFactory {
  func makeCoordinator() -> BaseCoordinator<MainTabRoutePath>
}
