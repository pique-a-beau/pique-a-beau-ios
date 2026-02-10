import HomeFeatureInterface
import MainTabFeatureInterface
import ProfileFeatureInterface
import Swinject

public final class MainTabAssembly: Assembly {
  
  public init() {}

  public func assemble(container: Container) {
    container.register(MainTabFactory.self) { resolver in
      DefaultMainTabFactory(
        homeFactory: resolver.resolve(HomeFactory.self)!,
        profileFactory: resolver.resolve(ProfileFactory.self)!
      )
    }
  }
}
