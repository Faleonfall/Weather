import Foundation

// Filters city forecasts by location text. An empty or whitespace-only query
// returns everything. No UI dependency so it stays testable.
enum CitySearch {

    static func filter(_ forecasts: [Forecast], query: String) -> [Forecast] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return forecasts }
        return forecasts.filter { $0.location.localizedCaseInsensitiveContains(trimmed) }
    }
}
