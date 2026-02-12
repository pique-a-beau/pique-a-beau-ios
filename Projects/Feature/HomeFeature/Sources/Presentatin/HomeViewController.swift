import FeatureFoundation
import HomeFeatureInterface
import RxSwift
import UIKit

public final class HomeViewController: BaseViewController {
  
  private let viewModel: HomeViewModel
  private let _routes = PublishSubject<HomeRoutePath>()
  var routes: Observable<HomeRoutePath> { _routes.asObservable() }
  
  private var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  // MARK: - Section & Item
  
  enum Section: Int, CaseIterable {
    case grid
    case horizontal
  }
  
  struct Item: Hashable {
    let id: UUID = UUID()
    let title: String
    let color: UIColor
    let imageName: String?
    
    init(title: String, color: UIColor, imageName: String? = nil) {
      self.title = title
      self.color = color
      self.imageName = imageName
    }
  }

  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func setupSubviews() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    
    configureDataSource()
  }

  override public func setupLayout() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }

  override public func bindState() {
    title = "홈"
    
    let output = viewModel.transform(
      input: .init(viewDidLoad: viewDidLoadPublisher)
    )
    
    applyInitialSnapshot()
  }
  
  // MARK: - Compositional Layout
  
  private func createLayout() -> UICollectionViewLayout {
    return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
      guard let section = Section(rawValue: sectionIndex) else { return nil }
      
      switch section {
      case .grid:
        return self.createGridSection()
      case .horizontal:
        return self.createHorizontalSection()
      }
    }
  }
  
  private func createGridSection() -> NSCollectionLayoutSection {
    // Item
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.5),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
    
    // Group
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(150)
    )
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    // Section
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    
    return section
  }
  
  private func createHorizontalSection() -> NSCollectionLayoutSection {
    // Item
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .absolute(200),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
    
    // Group
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .absolute(200),
      heightDimension: .absolute(200)
    )
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    // Section
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    
    return section
  }
  
  // MARK: - DataSource
  
  private func configureDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<ImageCell, Item> { cell, indexPath, item in
      cell.configure(with: item)
    }
    
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(
      collectionView: collectionView
    ) { collectionView, indexPath, item in
      return collectionView.dequeueConfiguredReusableCell(
        using: cellRegistration,
        for: indexPath,
        item: item
      )
    }
  }
  
  private func applyInitialSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    // Grid Section: 2 * 10 = 20개 아이템 (alien 이미지 사용)
    snapshot.appendSections([.grid])
    let gridItems = (0..<20).map { 
      Item(title: "Alien \($0 + 1)", color: .systemBackground, imageName: "alien-Photoroom")
    }
    snapshot.appendItems(gridItems, toSection: .grid)
    
    // Horizontal Section: 10개 아이템
    snapshot.appendSections([.horizontal])
    let horizontalItems = (0..<10).map { 
      Item(title: "Horizontal \($0 + 1)", color: .systemOrange)
    }
    snapshot.appendItems(horizontalItems, toSection: .horizontal)
    
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}

// MARK: - ImageCell

private final class ImageCell: UICollectionViewCell {
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .medium)
    label.textColor = .white
    label.textAlignment = .center
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
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    ])
  }
  
  func configure(with item: HomeViewController.Item) {
    titleLabel.text = item.title
    
    if let imageName = item.imageName, let image = UIImage(named: imageName) {
      imageView.image = image
      imageView.backgroundColor = .clear
      imageView.contentMode = .scaleAspectFit
    } else {
      imageView.image = nil
      imageView.backgroundColor = item.color
      imageView.contentMode = .scaleAspectFill
    }
  }
}
