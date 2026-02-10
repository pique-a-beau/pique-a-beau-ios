import FeatureFoundation
import SigninFeatureInterface
import RxSwift
import UIKit

final class SigninViewController: BaseViewController {
  
  private let viewModel: SigninViewModel
  private let _routes = PublishSubject<SigninRoutePath>()
  var routes: Observable<SigninRoutePath> { _routes.asObservable() }

  init(viewModel: SigninViewModel) {
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
    let output = viewModel.transform(
      input: .init(viewDidLoad: viewDidLoadPublisher)
    )
  }

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "로그인 화면"
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
}
