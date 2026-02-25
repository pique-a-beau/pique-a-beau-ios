import SwiftUI

public struct OnboardingView: View {
  
  @ObservedObject var viewModel: OnboardingViewModel
  
  public init(viewModel: OnboardingViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack {
      Color(.systemBackground)
        .ignoresSafeArea()
      
      VStack(spacing: 0) {
        // Page Content
        TabView(selection: $viewModel.currentPage) {
          ForEach(Array(viewModel.pages.enumerated()), id: \.element.id) { index, page in
            OnboardingPageView(page: page)
              .tag(index)
          }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        
        Spacer()
          .frame(height: 20)
        
        // Complete Button
        if viewModel.isLastPage {
          Button(action: {
            viewModel.completeOnboarding()
          }) {
            Text("시작하기")
              .font(.system(size: 18, weight: .bold))
              .foregroundColor(.white)
              .frame(maxWidth: .infinity)
              .frame(height: 56)
              .background(Color.blue)
              .cornerRadius(12)
          }
          .padding(.horizontal, 32)
          .padding(.bottom, 20)
          .transition(.opacity)
        } else {
          Spacer()
            .frame(height: 76)
        }
      }
    }
  }
}

// MARK: - OnboardingPageView

struct OnboardingPageView: View {
  
  let page: OnboardingPage
  
  var body: some View {
    VStack(spacing: 40) {
      Spacer()
      
      Image(systemName: page.systemImage)
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
        .foregroundColor(page.color.swiftUIColor)
      
      VStack(spacing: 16) {
        Text(page.title)
          .font(.system(size: 32, weight: .bold))
          .multilineTextAlignment(.center)
        
        Text(page.description)
          .font(.system(size: 18, weight: .regular))
          .foregroundColor(.secondary)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 32)
      }
      
      Spacer()
    }
  }
}

// MARK: - Color Extension

extension Color {
  var swiftUIColor: SwiftUI.Color {
    switch self {
    case .blue:
      return .blue
    case .purple:
      return .purple
    case .green:
      return .green
    }
  }
}

// MARK: - Preview

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView(viewModel: OnboardingViewModel())
  }
}
#endif
