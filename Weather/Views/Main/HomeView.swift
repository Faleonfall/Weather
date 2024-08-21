import SwiftUI
import BottomSheet

class HomeViewSettings: ObservableObject {
    @Published var isPresented = false
    @Published var bottomSheetPosition: BottomSheet.PresentationDetent = .fraction(0.83)  // Default to top position
}

struct HomeView: View {
    @StateObject var settings = HomeViewSettings()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Color
                Color.background
                    .ignoresSafeArea()
                
                // Background Image
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                // House Image
                Image("House")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 257)
                
                VStack(spacing: -10) {
                    Text("Berlin")
                        .font(.largeTitle)
                    
                    VStack {
                        Text(attributedString)
                            .multilineTextAlignment(.center)
                        
                        Text("H:29°   L:18°")
                            .font(.title3.weight(.semibold))
                    }
                    
                    Spacer()
                }
                .padding(.top, 51)
                
                // Tab Bar
                TabBar(action: {
                    settings.isPresented = true
                    settings.bottomSheetPosition = .fraction(0.83)
                })
            }
            .sheetPlus(
                isPresented: $settings.isPresented,
                background: (
                    ForecastView()
                        .presentationDetentsPlus(
                        [.fraction(0.385), .fraction(0.83)],  // Middle and Top positions
                        selection: $settings.bottomSheetPosition
                    )
                ),
                main: {
                    EmptyView()
                }
            )
            .navigationBarHidden(true)
        }
        .environmentObject(settings)
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("25°" + "\n" + "Clear")
        
        if let temp = string.range(of: "25°") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .primary
        }
        
        if let weather = string.range(of: "Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}

#Preview {
    HomeView()
}
