import SwiftUI

@main
struct WeatherApp: App {
    @State private var store = WeatherStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .colorScheme(.dark)
                .environment(store)
        }
    }
}
