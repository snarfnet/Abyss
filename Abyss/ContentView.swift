import SwiftUI

struct ContentView: View {
    @StateObject private var records = RecordStore()
    @State private var tab: Int

    init(screenshotIndex: Int? = nil) {
        _tab = State(initialValue: screenshotIndex ?? 0)
    }

    var body: some View {
        TabView(selection: $tab) {
            ReflectView()
                .tabItem { Label("観想", systemImage: "eye") }
                .tag(0)
            DailyView()
                .tabItem { Label("今日", systemImage: "sun.min") }
                .tag(1)
            RecordsView()
                .tabItem { Label("記録", systemImage: "scroll") }
                .tag(2)
            LoreView()
                .tabItem { Label("深淵", systemImage: "moon.stars") }
                .tag(3)
        }
        .environmentObject(records)
        .tint(Abyss.irisHi)
        .preferredColorScheme(.dark)
    }
}
