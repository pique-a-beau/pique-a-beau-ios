import FeatureFoundation
import MainTabFeatureInterface
import RxCocoa
import RxSwift
import UIKit

public final class MainTabBarController: UITabBarController {
  
  private let viewModel: MainTabViewModel
  private let _routes = PublishSubject<MainTabRoutePath>()
  var routes: Observable<MainTabRoutePath> { _routes.asObservable() }
  private let disposeBag = DisposeBag()

  public init(viewModel: MainTabViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  public required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    setupTabBarAppearance()
  }

  private func setupTabBarAppearance() {
    tabBar.tintColor = .systemBlue
    tabBar.backgroundColor = .systemBackground
  }
}
