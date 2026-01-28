import ActivityFeatureInterface
import Swinject

public final class ActivityAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(ActivityFactory.self) { _ in
            ActivityFactoryImpl()
        }
    }
}
