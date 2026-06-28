import SwiftUI

struct WeatherView: View {
    @State private var searchText = ""

    var searchResults: [Forecast] {
        CitySearch.filter(SampleForecasts.cities, query: searchText)
    }

    var body: some View {
        ZStack {
            // MARK: Background
            Color.background
                .ignoresSafeArea()

            // MARK: Weather Widgets
            ScrollView(
                showsIndicators: false,
                content: {
                    VStack(
                        spacing: 20,
                        content: {
                            ForEach(searchResults) { forecast in
                                WeatherWidget(forecast: forecast)
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
            // MARK: Navigation Bar
            NavigationBar(searchText: $searchText)
        })
        .navigationBarHidden(true)
        //        .searchable(text: $searchText, prompt: "Search for a city or airport")
        //        .foregroundColor(.white)
    }
}

#Preview {
    NavigationView {
        WeatherView()
    }
}
