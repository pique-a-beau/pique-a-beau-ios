import UIKit
import RxSwift

// MARK: - Coordinator

public protocol Coordinator: AnyObject {
  var rootViewController: UIViewController { get }
  var parent: Coordinator? { get set }
  func start()
}


