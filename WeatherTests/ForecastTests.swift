import Foundation
import Testing

@testable import Weather

struct ForecastTests {

    @Test func cityDropsCountrySuffix() {
        let forecast = Forecast(
            date: .now, weather: .clear, probability: 0, temperature: 25, high: 29, low: 18,
            location: "Berlin, Germany")
        #expect(forecast.city == "Berlin")
    }

    @Test func cityWithoutCommaReturnsWholeLocation() {
        let forecast = Forecast(
            date: .now, weather: .clear, probability: 0, temperature: 25, high: 29, low: 18,
            location: "Singapore")
        #expect(forecast.city == "Singapore")
    }
}
