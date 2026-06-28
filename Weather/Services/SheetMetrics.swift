import CoreGraphics

// Pure math for the home screen's bottom sheet. Drives how far the artwork and
// current-weather block move as the sheet is dragged. No UI dependency so it
// stays testable.
enum SheetMetrics {
    // Sheet detents as a fraction of screen height.
    static let collapsed: CGFloat = 0.425
    static let expanded: CGFloat = 0.83

    // Temperature font sizes for the collapsed and expanded states.
    static let maxTemperatureFontSize: CGFloat = 96
    static let minTemperatureFontSize: CGFloat = 20

    // Maps a sheet translation fraction to 0...1, where 0 is fully collapsed and
    // 1 is fully expanded.
    static func prorated(_ translation: CGFloat) -> CGFloat {
        abs((translation - collapsed) / (expanded - collapsed))
    }

    // Interpolates the current-weather temperature size from the prorated value.
    static func temperatureFontSize(prorated: CGFloat) -> CGFloat {
        maxTemperatureFontSize - (prorated * (maxTemperatureFontSize - minTemperatureFontSize))
    }
}
