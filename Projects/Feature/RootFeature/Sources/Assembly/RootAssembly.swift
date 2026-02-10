import FeatureFoundation
import MainTabFeatureInterface
import SplashFeatureInterface
import Swinject

public final class RootAssembly: Assembly {

  // MARK: Lifecycle

  public init() { }

  // MARK: Public

  public func assemble(container: Container) {
    container.register(RootCoordinator.self) { resolver, window in
      RootCoordinator(
        window: window,
        splashFactory: resolver.resolve(SplashFactory.self)!,
        mainTabFactory: resolver.resolve(MainTabFactory.self)!,
      )
    }
  }
}
