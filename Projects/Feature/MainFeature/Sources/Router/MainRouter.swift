import BaseFeature

public enum MainRoutePath: RoutePath {
    case main
    case selectTab(tab: Int)
}

final class MainRouter: Router {
    typealias RoutePath = MainRoutePath
    var navigationController = UINavigationController()

    func route(to path: MainRoutePath) {
        switch path {
        case .main:
            print("Main")
        case let .selectTab(tab):
            print("Tab \(tab)")
        }
    }
}
