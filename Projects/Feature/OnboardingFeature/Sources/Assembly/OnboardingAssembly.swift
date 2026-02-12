import OnboardingFeatureInterface
import Swinject

public final class OnboardingAssembly: Assembly {
  
  public init() {}

  public func assemble(container: Container) {
    container.register(OnboardingFactory.self) { _ in
      DefaultOnboardingFactory()
    }
  }
}
