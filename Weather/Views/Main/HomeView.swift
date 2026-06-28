import BottomSheet
import SwiftUI

@Observable
class HomeViewSettings {
    var isPresented = true  // Controls visibility of the sheet
    var bottomSheetPosition: BottomSheet.PresentationDetent = .fraction(SheetMetrics.collapsed)  // Default to middle position
}

struct HomeView: View {
    var currentForecast: Forecast = SampleForecasts.current

    @State var settings = HomeViewSettings()
    @State var bottomSheetTranslation: CGFloat = SheetMetrics.collapsed
    @State var hasDragged: Bool = false

    var bottomSheetTranslationProrated: CGFloat {
        SheetMetrics.prorated(bottomSheetTranslation)
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight =
                    geometry.size.height + geometry.safeAreaInsets.top
                    + geometry.safeAreaInsets.bottom

                let imageOffset = screenHeight + 36

                ZStack {
                    // Background Color
                    Color.background
                        .ignoresSafeArea()

                    // Background Image
                    Image("Background")
                        .resizable()
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                        .ignoresSafeArea()

                    // House Image
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)

                    // MARK: Current Weather
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrated)) {
                        Text(currentForecast.city)
                            .font(.largeTitle)

                        VStack {
                            Text(attributedString)
                                .multilineTextAlignment(.center)

                            Text(
                                TemperatureFormat.highLow(
                                    high: currentForecast.high, low: currentForecast.low,
                                    separator: "   ")
                            )
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
                            if settings.bottomSheetPosition == .fraction(SheetMetrics.expanded) {
                                hasDragged = true
                            } else {
                                hasDragged = false
                            }
                        }

                    },
                    main: {
                        ForecastView(bottomSheetTranlationProrated: bottomSheetTranslationProrated)
                            .presentationDetentsPlus(
                                [
                                    .fraction(SheetMetrics.collapsed),
                                    .fraction(SheetMetrics.expanded),
                                ],  // Hidden, Middle, and Top positions
                                selection: $settings.bottomSheetPosition
                            )
                    }
                )

                // MARK: Tab Bar
                .overlay(
                    VStack {
                        Spacer()  // Pushes the TabBar to the bottom
                        TabBar(action: {
                            withAnimation {
                                if settings.bottomSheetPosition == .fraction(SheetMetrics.collapsed)
                                {
                                    settings.bottomSheetPosition = .fraction(SheetMetrics.expanded)
                                } else {
                                    settings.bottomSheetPosition = .fraction(SheetMetrics.collapsed)
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
        .environment(settings)
    }

    private var attributedString: AttributedString {
        let temperature = TemperatureFormat.degrees(currentForecast.temperature)
        let condition = currentForecast.weather.rawValue

        var string = AttributedString(temperature + (hasDragged ? "" : "\n") + condition)

        if let temp = string.range(of: temperature) {
            string[temp].font = .system(
                size: SheetMetrics.temperatureFontSize(prorated: bottomSheetTranslationProrated),
                weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }

        if let weather = string.range(of: condition) {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }

        return string
    }
}

#Preview {
    HomeView()
}
