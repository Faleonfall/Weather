# Weather ☀️

An iOS weather app with a draggable forecast sheet.
Shows current conditions, an hourly timeline, a weekly outlook, and a list of cities.

---

## 🧭 Features

* Bottom sheet that expands and collapses with drag tracking
* Background and house art that shift as the sheet moves
* Current conditions with temperature, condition, and daily high/low
* Hourly and weekly forecast views switched with a segmented control
* City list with per-city conditions and temperatures
* Condition-based weather icons and a custom tab bar

---

## 🛠️ Tech Stack

* **Language:** Swift 6
* **UI:** SwiftUI
* **Platform:** iOS 18.0+
* **Architecture:** MV with plain model data
* **Dependencies:** [BottomSheet](https://github.com/Wouter125/BottomSheet)

---

## 🚀 Setup

```bash
git config core.hooksPath .githooks   # enable swift-format pre-commit hook
open Weather.xcodeproj
```

Build and run from Xcode, or use the CLI helper:

```bash
scripts/xc.sh build   # build for the pinned simulator
scripts/xc.sh test    # run the unit tests
```

---

## 📦 About

A learning project recreating a SwiftUI weather UI with a gesture-driven forecast
sheet. Forecast data is static sample data, so the focus is layout and interaction
rather than a live weather API.
