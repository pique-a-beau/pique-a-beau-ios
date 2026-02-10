import FeatureFoundation
import HomeFeatureInterface
import RxSwift
import UIKit

public final class HomeViewController: BaseViewController {
  
  private let viewModel: HomeViewModel
  private let _routes = PublishSubject<HomeRoutePath>()
  var routes: Observable<HomeRoutePath> { _routes.asObservable() }

  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func setupSubviews() {
    view.addSubview(titleLabel)
  }

  override public func setupLayout() {
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }

  override public func bindState() {
    title = "홈"
    
    let output = viewModel.transform(
      input: .init(viewDidLoad: viewDidLoadPublisher)
    )
  }

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "홈 화면"
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
}
