import SwiftUI

struct ContentView: View {
    @Environment(WeatherStore.self) var store

    var body: some View {
        ZStack {
            HomeView()

            if store.isShowingCityList {
                WeatherView()
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(WeatherStore())
}
