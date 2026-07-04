import Testing

@testable import Weather

struct CitySearchTests {

    @Test func emptyQueryReturnsAll() {
        let results = CitySearch.filter(SampleForecasts.cities, query: "")
        #expect(results.count == SampleForecasts.cities.count)
    }

    @Test func matchIsCaseInsensitive() {
        let results = CitySearch.filter(SampleForecasts.cities, query: "tok")
        #expect(results.count == 1)
        #expect(results.first?.location == "Tokyo, Japan")
    }

    @Test func whitespaceQueryReturnsAll() {
        let results = CitySearch.filter(SampleForecasts.cities, query: "   ")
        #expect(results.count == SampleForecasts.cities.count)
    }

    @Test func noMatchReturnsEmpty() {
        let results = CitySearch.filter(SampleForecasts.cities, query: "Atlantis")
        #expect(results.isEmpty)
    }

    @Test func queryMatchesAnywhereInLocation() {
        let results = CitySearch.filter(SampleForecasts.cities, query: "Canada")
        #expect(results.count == 2)
    }
}
