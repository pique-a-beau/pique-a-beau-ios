import ProfileFeatureInterface
import Swinject

public final class ProfileAssembly: Assembly {
  
  public init() {}

  public func assemble(container: Container) {
    container.register(ProfileFactory.self) { _ in
      DefaultProfileFactory()
    }
  }
}
