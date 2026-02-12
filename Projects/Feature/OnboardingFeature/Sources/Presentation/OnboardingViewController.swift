import FeatureFoundation
import OnboardingFeatureInterface
import RxSwift
import RxCocoa
import UIKit

public final class OnboardingViewController: BaseViewController {
  
  private let viewModel: OnboardingViewModel
  private let _routes = PublishSubject<OnboardingRoutePath>()
  var routes: Observable<OnboardingRoutePath> { _routes.asObservable() }
  
  private var collectionView: UICollectionView!
  private var pageControl: UIPageControl!
  private var completeButton: UIButton!
  private var currentPage = 0
  
  private let pages: [OnboardingPage] = [
    OnboardingPage(
      title: "환영합니다",
      description: "Pique-à-Beau에 오신 것을 환영합니다",
      systemImage: "hand.wave.fill",
      color: .systemBlue
    ),
    OnboardingPage(
      title: "다양한 기능",
      description: "다양한 기능을 탐색하고 활용해보세요",
      systemImage: "sparkles",
      color: .systemPurple
    ),
    OnboardingPage(
      title: "시작하기",
      description: "지금 바로 시작해볼까요?",
      systemImage: "arrow.right.circle.fill",
      color: .systemGreen
    )
  ]

  init(viewModel: OnboardingViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func setupSubviews() {
    view.backgroundColor = .systemBackground
    
    // CollectionView
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isPagingEnabled = true
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .clear
    view.addSubview(collectionView)
    
    // PageControl
    pageControl = UIPageControl()
    pageControl.numberOfPages = pages.count
    pageControl.currentPage = 0
    pageControl.currentPageIndicatorTintColor = .systemBlue
    pageControl.pageIndicatorTintColor = .systemGray4
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(pageControl)
    
    // Complete Button
    completeButton = UIButton(type: .system)
    completeButton.setTitle("시작하기", for: .normal)
    completeButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    completeButton.backgroundColor = .systemBlue
    completeButton.setTitleColor(.white, for: .normal)
    completeButton.layer.cornerRadius = 12
    completeButton.translatesAutoresizingMaskIntoConstraints = false
    completeButton.alpha = 0
    view.addSubview(completeButton)
  }

  override public func setupLayout() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20),
      
      pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      pageControl.bottomAnchor.constraint(equalTo: completeButton.topAnchor, constant: -20),
      
      completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
      completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      completeButton.heightAnchor.constraint(equalToConstant: 56),
    ])
  }

  override public func bindState() {
    let output = viewModel.transform(
      input: .init(
        viewDidLoad: viewDidLoadPublisher,
        completeButtonTapped: completeButton.rx.tap.asObservable()
      )
    )
    
    output.route
      .bind(to: _routes)
      .disposed(by: disposeBag)
  }
  
  private func updateButtonVisibility() {
    let isLastPage = currentPage == pages.count - 1
    UIView.animate(withDuration: 0.3) {
      self.completeButton.alpha = isLastPage ? 1 : 0
    }
  }
}

// MARK: - UICollectionViewDataSource

extension OnboardingViewController: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pages.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
    cell.configure(with: pages[indexPath.item])
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension OnboardingViewController: UICollectionViewDelegate {
  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let pageWidth = scrollView.frame.width
    currentPage = Int(scrollView.contentOffset.x / pageWidth)
    pageControl.currentPage = currentPage
    updateButtonVisibility()
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.bounds.size
  }
}

// MARK: - OnboardingPage

struct OnboardingPage {
  let title: String
  let description: String
  let systemImage: String
  let color: UIColor
}

// MARK: - OnboardingCell

private final class OnboardingCell: UICollectionViewCell {
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 32, weight: .bold)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18, weight: .regular)
    label.textAlignment = .center
    label.textColor = .secondaryLabel
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    contentView.addSubview(imageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(descriptionLabel)
    
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -80),
      imageView.widthAnchor.constraint(equalToConstant: 200),
      imageView.heightAnchor.constraint(equalToConstant: 200),
      
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
      
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
      descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
      descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
    ])
  }
  
  func configure(with page: OnboardingPage) {
    let config = UIImage.SymbolConfiguration(pointSize: 120, weight: .regular)
    imageView.image = UIImage(systemName: page.systemImage, withConfiguration: config)
    imageView.tintColor = page.color
    titleLabel.text = page.title
    descriptionLabel.text = page.description
  }
}
