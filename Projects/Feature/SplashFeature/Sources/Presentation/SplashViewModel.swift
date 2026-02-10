import FeatureFoundation
import SplashFeatureInterface
import Foundation
import RxSwift

final class SplashViewModel: ViewModel {
  
  enum State {
    case idle
    case loading
    case error(String)
  }

  struct Input {
    let viewDidLoad: Observable<Void>
  }

  struct Output {
    let state: Observable<State>
    let route: Observable<SplashRoutePath>
  }

  private let disposeBag = DisposeBag()

  func transform(input: Input) -> Output {
    let state = BehaviorSubject<State>(value: .idle)
    let route = PublishSubject<SplashRoutePath>()

    input.viewDidLoad
      .delay(.seconds(2), scheduler: MainScheduler.instance)
      .subscribe(onNext: {
        state.onNext(.loading)
        route.onNext(.mainTab)
        state.onNext(.idle)
      })
      .disposed(by: disposeBag)

    return Output(state: state, route: route)
  }
}
