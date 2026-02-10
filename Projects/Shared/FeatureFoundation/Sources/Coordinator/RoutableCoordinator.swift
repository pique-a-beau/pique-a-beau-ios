import UIKit
import RxSwift


public protocol RoutePath { }

public protocol Routable: Coordinator {
  associatedtype RoutePath
  var routes: PublishSubject<RoutePath> { get }
}

//open class RoutableCoordinator<Route>: Coordinator {
//  public var rootViewController: UIViewController
//  public let routes: Observable<Route>
//
//  public init<C: Routable>(_ coordinator: C) where C.RoutePath == Route {
//    self.rootViewController = coordinator.rootViewController
//    self.routes = coordinator.routes
//  }
//
//  open func start() {
//    fatalError("start() must be overridden")
//  }
//
//}
