import FeatureFoundation
import SplashFeatureInterface
import UIKit
import RxSwift
import RxCocoa

final class SplashViewController: BaseViewController {
  
  private let viewModel: SplashViewModel
  private let _routes = PublishSubject<SplashRoutePath>()
  var routes: Observable<SplashRoutePath> { _routes.asObservable() }

  init(viewModel: SplashViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func setupSubviews() {
    view.addSubview(logoImageView)
    view.addSubview(titleLabel)
    view.addSubview(activityIndicator)
    view.addSubview(errorLabel)
  }

  override public func setupLayout() {
    NSLayoutConstraint.activate([
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
      logoImageView.widthAnchor.constraint(equalToConstant: 120),
      logoImageView.heightAnchor.constraint(equalToConstant: 120),

      titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

      activityIndicator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      errorLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 16),
      errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
    ])
  }

  override public func bindState() {
    let output = viewModel.transform(
      input: .init(viewDidLoad: viewDidLoadPublisher)
    )

    output.state
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in self?.render(state: $0) })
      .disposed(by: disposeBag)

    output.route
      .bind(to: _routes)
      .disposed(by: disposeBag)
  }

  private let logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Splash View"
    label.font = .systemFont(ofSize: 32, weight: .bold)
    label.textAlignment = .center
    label.textColor = .label
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.color = .systemBlue
    indicator.hidesWhenStopped = true
    indicator.translatesAutoresizingMaskIntoConstraints = false
    return indicator
  }()

  private let errorLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .regular)
    label.textColor = .systemRed
    label.textAlignment = .center
    label.numberOfLines = 0
    label.isHidden = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private func render(state: SplashViewModel.State) {
    switch state {
    case .idle:
      activityIndicator.stopAnimating()
    case .loading:
      activityIndicator.startAnimating()
    case .error(let message):
      activityIndicator.stopAnimating()
      errorLabel.text = message
      errorLabel.isHidden = false
    }
  }
}
