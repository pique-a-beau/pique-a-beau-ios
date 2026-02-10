import ProfileFeatureInterface
import UIKit

public struct MockProfileFactory: ProfileFactory {
  public init() { }

  public func makeViewController() -> UIViewController {
    UIViewController()
  }
}
