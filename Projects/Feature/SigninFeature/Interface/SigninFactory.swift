import FeatureFoundation

public protocol SigninFactory {
  func makeCoordinator() -> BaseCoordinator<SigninRoutePath>
}
