import CoinDomainInterface
import RxSwift

public struct CoinListUseCaseImpl: CoinListUseCase {
  init(coinListRepository: CoinListRepository) {
    self.coinListRepository = coinListRepository
  }

  public func getCoinList() -> Observable<[Coin]> {
    coinListRepository.fetchCoinList()
  }

  private let coinListRepository: CoinListRepository

}
