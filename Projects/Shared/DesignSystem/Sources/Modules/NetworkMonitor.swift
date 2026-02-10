import Network

final class NetworkMonitor {

  // MARK: Lifecycle

  init() {
    monitor = NWPathMonitor()
  }

  // MARK: Internal

  typealias StatusHandler = (NWPath.Status) -> Void

  func startMonitoring(statusUpdateHandler: @escaping StatusHandler) {
    monitor.pathUpdateHandler = { path in
      DispatchQueue.main.async {
        statusUpdateHandler(path.status)
      }
    }

    monitor.start(queue: queue)
  }

  func stopMonitoring() {
    monitor.cancel()
  }

  func currentNetworkState() -> NWPath {
    monitor.currentPath
  }

  // MARK: Private

  private let queue = DispatchQueue.global(qos: .background)
  private var monitor: NWPathMonitor

}
