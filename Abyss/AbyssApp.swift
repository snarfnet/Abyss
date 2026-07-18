import SwiftUI

@main
struct AbyssApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(screenshotIndex: Self.screenshotTab)
                .onAppear { Self.styleTabBar() }
                .preferredColorScheme(.dark)
        }
    }

    /// Read SCREENSHOT_MODE_N from launch args to open a specific tab.
    static var screenshotTab: Int? {
        for arg in CommandLine.arguments where arg.hasPrefix("SCREENSHOT_MODE_") {
            if let n = Int(arg.replacingOccurrences(of: "SCREENSHOT_MODE_", with: "")) {
                return max(0, min(3, n - 1))
            }
        }
        return nil
    }

    static func styleTabBar() {
        let a = UITabBarAppearance()
        a.configureWithOpaqueBackground()
        a.backgroundColor = UIColor(red: 0.03, green: 0.04, blue: 0.07, alpha: 1)
        UITabBar.appearance().standardAppearance = a
        UITabBar.appearance().scrollEdgeAppearance = a
    }
}
