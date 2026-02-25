import SwiftUI
import UIKit
import OnboardingFeatureInterface
import RxSwift

public final class OnboardingViewController: UIViewController {
  
  private let viewModel: OnboardingViewModel
  private let _routes = PublishSubject<OnboardingRoutePath>()
  var routes: Observable<OnboardingRoutePath> { _routes.asObservable() }
  
  public init(viewModel: OnboardingViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    
    viewModel.setOnComplete { [weak self] in
      self?._routes.onNext(.completeOnboarding)
    }
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setupSwiftUIView()
  }
  
  private func setupSwiftUIView() {
    let onboardingView = OnboardingView(viewModel: viewModel)
    let hostingController = UIHostingController(rootView: onboardingView)
    
    addChild(hostingController)
    view.addSubview(hostingController.view)
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
    
    hostingController.didMove(toParent: self)
  }
}
