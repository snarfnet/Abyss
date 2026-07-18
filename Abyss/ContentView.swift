import SwiftUI

struct ContentView: View {
    @StateObject private var records = RecordStore()
    @State private var tab: Int

    init(screenshotIndex: Int? = nil) {
        _tab = State(initialValue: screenshotIndex ?? 0)
    }

    var body: some View {
        TabView(selection: $tab) {
            ConsultView()
                .tabItem { Label("眼", systemImage: "eye") }
                .tag(0)
            ProphecyView()
                .tabItem { Label("予言", systemImage: "sparkles") }
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
