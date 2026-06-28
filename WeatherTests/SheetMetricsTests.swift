import CoreGraphics
import Testing

@testable import Weather

struct SheetMetricsTests {

    @Test func proratedIsZeroWhenCollapsed() {
        #expect(abs(SheetMetrics.prorated(SheetMetrics.collapsed)) < 0.0001)
    }

    @Test func proratedIsOneWhenExpanded() {
        #expect(abs(SheetMetrics.prorated(SheetMetrics.expanded) - 1) < 0.0001)
    }

    @Test func proratedIsHalfwayAtMidpoint() {
        let mid = (SheetMetrics.collapsed + SheetMetrics.expanded) / 2
        #expect(abs(SheetMetrics.prorated(mid) - 0.5) < 0.0001)
    }

    @Test func fontSizeIsMaxWhenCollapsed() {
        #expect(
            SheetMetrics.temperatureFontSize(prorated: 0) == SheetMetrics.maxTemperatureFontSize)
    }

    @Test func fontSizeIsMinWhenExpanded() {
        #expect(
            SheetMetrics.temperatureFontSize(prorated: 1) == SheetMetrics.minTemperatureFontSize)
    }
}
