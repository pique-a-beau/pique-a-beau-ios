import BaseFeature
import HomeFeatureInterface
import SigninFeatureInterface
import UIKit

public final class MainCoordinator: BaseCoordinator {
    private let mainRouter: MainRouter
    private let tabBarController: MainTabBarController
    private let homeFactory: HomeFactory
    private let signInFactory: SignInFactory

    override public var rootViewController: UIViewController {
        mainRouter.navigationController
    }

    init(
        mainRouter: MainRouter,
        tabBarController: MainTabBarController,
        homeFactory: HomeFactory,
        signInFacgory _: SigninFactory
    ) {
        self.mainRouter = mainRouter
        self.tabBarController = tabBarController
        self.homeFactory = homeFactory
    }

    override public func start() {}

    private func showHomeView() {
        mainRouter.route(to: .main)
    }
}
