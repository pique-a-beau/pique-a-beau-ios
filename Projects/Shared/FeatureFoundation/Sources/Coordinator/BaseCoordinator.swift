import UIKit
import RxSwift

// MARK: - BaseCoordinator

open class BaseCoordinator<Route: RoutePath>: Coordinator {
  public let routes = PublishSubject<Route>()

  // MARK: Lifecycle

  public init() { }

  // MARK: Open

  open var rootViewController: UIViewController {
    fatalError("Subclasses must override rootViewController")
  }

  open func start() {
    fatalError("start() must be overridden")
  }

  // MARK: Public

  public weak var parent: Coordinator?
  public private(set) var children = [Coordinator]()
  public var disposeBag = DisposeBag()

  public func addChild(_ child: Coordinator) {
    children.append(child)
    child.parent = self
  }

  public func removeChild(_ child: Coordinator) {
    children.removeAll { $0 === child }
    child.parent = nil
  }

  public func removeAllChildren() {
    for child in children { child.parent = nil }
    children.removeAll()
  }
}
