import FeatureFoundation
import HomeFeatureInterface
import Foundation
import RxSwift

final class HomeViewModel: ViewModel {

  struct Input {
    let viewDidLoad: Observable<Void>
  }

  struct Output {
    let route: Observable<HomeRoutePath>
  }

  private let disposeBag = DisposeBag()

  func transform(input: Input) -> Output {
    let route = PublishSubject<HomeRoutePath>()
    
    return Output(route: route)
  }
}
