import Combine
import Foundation
import OnboardingFeatureInterface

final class OnboardingViewModel: ObservableObject {
  
  @Published var currentPage: Int = 0
  
  private(set) var onComplete: (() -> Void)?
  
  let pages: [OnboardingPage] = [
    OnboardingPage(
      title: "환영합니다",
      description: "Pique-à-Beau에 오신 것을 환영합니다",
      systemImage: "hand.wave.fill",
      color: .blue
    ),
    OnboardingPage(
      title: "다양한 기능",
      description: "다양한 기능을 탐색하고 활용해보세요",
      systemImage: "sparkles",
      color: .purple
    ),
    OnboardingPage(
      title: "시작하기",
      description: "지금 바로 시작해볼까요?",
      systemImage: "arrow.right.circle.fill",
      color: .green
    )
  ]
  
  var isLastPage: Bool {
    currentPage == pages.count - 1
  }
  
  func setOnComplete(_ completion: @escaping () -> Void) {
    self.onComplete = completion
  }
  
  func completeOnboarding() {
    onComplete?()
  }
}

// MARK: - OnboardingPage

struct OnboardingPage: Identifiable {
  let id = UUID()
  let title: String
  let description: String
  let systemImage: String
  let color: Color
}

enum Color {
  case blue
  case purple
  case green
}
