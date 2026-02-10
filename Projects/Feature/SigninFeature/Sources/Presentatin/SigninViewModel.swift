import FeatureFoundation
import SigninFeatureInterface
import Foundation
import RxSwift

final class SigninViewModel: ViewModel {

  struct Input {
    let viewDidLoad: Observable<Void>
  }

  struct Output {
    let route: Observable<SigninRoutePath>
  }

  private let disposeBag = DisposeBag()

  func transform(input: Input) -> Output {
    let route = PublishSubject<SigninRoutePath>()
    
    return Output(route: route)
  }
}
