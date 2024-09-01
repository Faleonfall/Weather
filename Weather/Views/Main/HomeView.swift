import SwiftUI
import BottomSheet

class HomeViewSettings: ObservableObject {
    @Published var isPresented = true  // Controls visibility of the sheet
    @Published var bottomSheetPosition: BottomSheet.PresentationDetent = .fraction(0.385)  // Default to middle position
}

struct HomeView: View {
    @StateObject var settings = HomeViewSettings()
    @State var bottomSheetTranslation: CGFloat = 0.385
    @State var hasDragged: Bool = false
    
    var bottomSheetTranslationProrated: CGFloat {
        abs((bottomSheetTranslation - 0.385) / (0.83 - 0.385))
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                
                let imageOffset = screenHeight + 36
                
                ZStack {
                    // Background Color
                    Color.background
                        .ignoresSafeArea()
                    
                    // Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    // House Image
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    // MARK: Current Weather
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrated)) {
                        Text("Berlin")
                            .font(.largeTitle)
                        
                        VStack {
                            Text(attributedString)
                                .multilineTextAlignment(.center)
                            
                            Text("H:29°   L:18°")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranslationProrated)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 75)
                    .offset(y: -bottomSheetTranslationProrated * 46)
                }
                
                // MARK: Bottom Sheet
                .sheetPlus(
                    isPresented: $settings.isPresented,
                    background: (EmptyView()),
                    onDrag: { translation in
                        bottomSheetTranslation = translation / screenHeight
                        
                        withAnimation(.easeInOut) {
                            if settings.bottomSheetPosition == .fraction(0.83) {
                                hasDragged = true
                            } else {
                                hasDragged = false
                            }
                        }
                        
                    },
                    main: {
                        ForecastView(bottomSheetTranlationProrated: bottomSheetTranslationProrated)
                            .presentationDetentsPlus(
                                [.fraction(0.385), .fraction(0.83)],  // Hidden, Middle, and Top positions
                                selection: $settings.bottomSheetPosition
                            )
                    }
                )
                
                // MARK: Tab Bar
                .overlay(
                    VStack {
                        Spacer() // Pushes the TabBar to the bottom
                        TabBar(action: {
                            withAnimation {
                                if settings.bottomSheetPosition == .fraction(0.385) {
                                    settings.bottomSheetPosition = .fraction(0.83)
                                }
                                settings.isPresented = true  // Ensure the sheet is always presented
                            }
                        })
                        .offset(y: bottomSheetTranslationProrated * 115)
                    }
                )
            }
            .navigationBarHidden(true)
        }
        .environmentObject(settings)
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("25°" + (hasDragged ? "" : "\n") + "Clear")
        
        if let temp = string.range(of: "25°") {
            string[temp].font = .system(size: (96 - (bottomSheetTranslationProrated * (96 - 20))), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProrated)
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
