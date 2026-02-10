import RxSwift
import UIKit

open class BaseView: UIView {

  // MARK: Lifecycle

  public init() {
    super.init(frame: .zero)
    setupSubViews()
    setupLayout()
  }

  @available(*, unavailable)
  public required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Open

  open func setupSubViews() { }
  open func setupLayout() { }
  open func configure() { }

  // MARK: Public

  public var disposeBag = DisposeBag()

}
