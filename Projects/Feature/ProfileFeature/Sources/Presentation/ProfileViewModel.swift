import FeatureFoundation
import ProfileFeatureInterface
import Foundation
import RxSwift

final class ProfileViewModel: ViewModel {

  struct Input {
    let viewDidLoad: Observable<Void>
  }

  struct Output {
    let route: Observable<ProfileRoutePath>
  }

  private let disposeBag = DisposeBag()

  func transform(input: Input) -> Output {
    let route = PublishSubject<ProfileRoutePath>()
    
    return Output(route: route)
  }
}
