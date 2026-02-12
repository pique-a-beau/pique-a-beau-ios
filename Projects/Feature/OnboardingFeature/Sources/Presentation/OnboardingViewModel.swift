import FeatureFoundation
import OnboardingFeatureInterface
import Foundation
import RxSwift

final class OnboardingViewModel: ViewModel {

  struct Input {
    let viewDidLoad: Observable<Void>
    let completeButtonTapped: Observable<Void>
  }

  struct Output {
    let route: Observable<OnboardingRoutePath>
  }

  private let disposeBag = DisposeBag()

  func transform(input: Input) -> Output {
    let route = PublishSubject<OnboardingRoutePath>()
    
    input.completeButtonTapped
      .map { OnboardingRoutePath.completeOnboarding }
      .bind(to: route)
      .disposed(by: disposeBag)
    
    return Output(route: route)
  }
}
