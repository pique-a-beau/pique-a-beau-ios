import SwiftUI

#if DEBUG
extension UIViewController {

  // MARK: Internal

  func toPreview() -> some View {
    Preview(viewController: self)
  }

  // MARK: Private

  private struct Preview: UIViewControllerRepresentable {
    let viewController: UIViewController

    func makeUIViewController(context _: Context) -> UIViewController {
      viewController
    }

    func updateUIViewController(_: UIViewController, context _: Context) { }
  }

}
#endif
