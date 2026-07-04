import Observation

// App-wide state. Holds the city shown on the home screen.
@Observable
final class WeatherStore {
    var currentForecast: Forecast = SampleForecasts.current

    // City list shows as an overlay, not a navigation push. Pushing takes
    // HomeView off screen, which resets the bottom sheet and makes it jump
    // when returning.
    var isShowingCityList = false
}
