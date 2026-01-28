@testable import ActivityFeature
import FamilyControls

// import UIKit
import SwiftUI

// @main
// class AppDelegate: UIResponder, UIApplicationDelegate {
//  var window: UIWindow?
//
//  func application(
//    _: UIApplication,
//    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
//  ) -> Bool {
//    window = UIWindow(frame: UIScreen.main.bounds)
//
////    let viewModel = ActivityViewModel()
////    let viewController = ActivityViewController(viewModel: viewModel)
//    let viewController = UIHostingController(rootView: ExampleView())
//    let navigationController = UINavigationController(rootViewController: viewController)
//
//    window?.rootViewController = navigationController
//    window?.makeKeyAndVisible()
//
//    Task {
//      do {
//        try await center.requestAuthorization(for: FamilyControlsMember.individual)
//      } catch {
//        print("error")
//      }
//    }
//
//    return true
//  }
// }

@main
struct ActivityFeatureDemo: App {
    let authorizationCenter = AuthorizationCenter.shared
    @StateObject var model = ActivityViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    NavigationLink(destination: ScreenTimeSelectAppsContentView(model: model)) {
                        Text("Select App")
                    }

                    NavigationLink(
                        destination: ExampleView(model: model)
                    ) {
                        Text("Device Activity")
                    }
                }
            }
            .onAppear {
                Task {
                    do {
                        try await authorizationCenter.requestAuthorization(for: .individual)
                    } catch {
                        print("Failure to enroll with error: \(error)")
                    }
                }
            }
        }
    }
}
