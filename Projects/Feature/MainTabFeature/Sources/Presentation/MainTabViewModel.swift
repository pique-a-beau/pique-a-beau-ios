import FeatureFoundation
import MainTabFeatureInterface
import Foundation
import RxSwift

public final class MainTabViewModel: ViewModel {

  struct Input {
    let viewDidLoad: Observable<Void>
  }

  struct Output {
    let route: Observable<MainTabRoutePath>
  }

  private let disposeBag = DisposeBag()

  func transform(input: Input) -> Output {
    let route = PublishSubject<MainTabRoutePath>()
    
    return Output(route: route)
  }
}
