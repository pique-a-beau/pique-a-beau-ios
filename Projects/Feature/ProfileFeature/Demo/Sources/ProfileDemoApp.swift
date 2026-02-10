import ProfileFeature
import SwiftUI

// MARK: - ProfileDemoApp

@main
struct ProfileDemoApp: App {
  var body: some Scene {
    WindowGroup {
      ProfileDemoView()
    }
  }
}

// MARK: - ProfileDemoView

struct ProfileDemoView: UIViewControllerRepresentable {
  func makeUIViewController(context _: Context) -> UIViewController {
    let factory = DefaultProfileFactory()
    return factory.makeViewController()
  }

  func updateUIViewController(_: UIViewController, context _: Context) { }
}
