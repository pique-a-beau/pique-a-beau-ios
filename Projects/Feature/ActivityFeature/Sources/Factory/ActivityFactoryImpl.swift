import ActivityFeatureInterface
import BaseFeature
import Foundation

struct ActivityFactoryImpl: ActivityFactory {
    func makeCoordinator() -> Coordinator {
        let activityViewModel = ActivityViewModel()
        let activityViewController = ActivityViewController()
        let router = ActivityRouter(activityViewController: activityViewController)
        return ActivityCoordinator(
            activityRouter: router,
            acvivityViewController: activityViewController
        )
    }
}
