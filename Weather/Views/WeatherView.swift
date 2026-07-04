import SwiftUI

struct WeatherView: View {
    @Environment(WeatherStore.self) var store
    @State private var searchText = ""

    var searchResults: [Forecast] {
        CitySearch.filter(SampleForecasts.cities, query: searchText)
    }

    var body: some View {
        ZStack {
            // MARK: - Background
            Color.background
                .ignoresSafeArea()

            // MARK: - Weather Widgets
            ScrollView(
                showsIndicators: false,
                content: {
                    VStack(
                        spacing: 20,
                        content: {
                            ForEach(searchResults) { forecast in
                                Button {
                                    store.currentForecast = forecast
                                    withAnimation(.easeInOut) {
                                        store.isShowingCityList = false
                                    }
                                } label: {
                                    WeatherWidget(forecast: forecast)
                                }
                                .buttonStyle(.plain)
                            }
                        })
                }
            )
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 100)
            }

        }
        .overlay(content: {
            // MARK: - Navigation Bar
            NavigationBar(searchText: $searchText)
        })
    }
}

#Preview {
    WeatherView()
        .environment(WeatherStore())
}
