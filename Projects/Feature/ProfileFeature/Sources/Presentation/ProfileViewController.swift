import FeatureFoundation
import ProfileFeatureInterface
import RxSwift
import UIKit

public final class ProfileViewController: BaseViewController {
  
  private let viewModel: ProfileViewModel
  private let _routes = PublishSubject<ProfileRoutePath>()
  var routes: Observable<ProfileRoutePath> { _routes.asObservable() }

  init(viewModel: ProfileViewModel) {
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
    title = "프로필"
    
    let output = viewModel.transform(
      input: .init(viewDidLoad: viewDidLoadPublisher)
    )
  }

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "프로필 화면"
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
}
