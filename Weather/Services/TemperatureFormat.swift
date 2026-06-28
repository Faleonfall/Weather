import Foundation

// Pure formatting of temperature values into display strings. No UI dependency
// so it stays testable.
enum TemperatureFormat {

    // A single temperature with a degree sign, e.g. 25 -> "25°".
    static func degrees(_ value: Int) -> String {
        "\(value)°"
    }

    // The daily high/low line, e.g. "H:29° L:18°". The separator lets callers
    // match their own spacing.
    static func highLow(high: Int, low: Int, separator: String = " ") -> String {
        "H:\(high)°\(separator)L:\(low)°"
    }
}
