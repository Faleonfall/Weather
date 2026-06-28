import Testing

@testable import Weather

struct TemperatureFormatTests {

    @Test func degreesAppendsSign() {
        #expect(TemperatureFormat.degrees(25) == "25°")
        #expect(TemperatureFormat.degrees(-3) == "-3°")
    }

    @Test func highLowUsesDefaultSeparator() {
        #expect(TemperatureFormat.highLow(high: 29, low: 18) == "H:29° L:18°")
    }

    @Test func highLowHonorsCustomSeparator() {
        #expect(TemperatureFormat.highLow(high: 29, low: 18, separator: "   ") == "H:29°   L:18°")
    }
}
