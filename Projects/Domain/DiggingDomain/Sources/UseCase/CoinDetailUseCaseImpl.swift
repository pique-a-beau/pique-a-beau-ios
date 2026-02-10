import CoinDomainInterface
import RxSwift

public final class CoinDetailUseCaseImpl: CoinDetailUseCase {

  // MARK: Lifecycle

  init(coinDetailRepository: CoinDetailRepository) {
    self.coinDetailRepository = coinDetailRepository
  }

  // MARK: Public

  public func getCoinDetail(of coinId: String) -> Observable<Coin> {
    coinDetailRepository.getCoinDetail(of: coinId)
  }

  // MARK: Private

  private let coinDetailRepository: CoinDetailRepository

}
