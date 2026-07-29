import Foundation
import SwiftUI

struct Record: Identifiable, Codable {
    var id = UUID()
    var question: String
    var lineJa: String
    var lineEn: String
    var source: String
    var date: Date = Date()
}

@MainActor
final class RecordStore: ObservableObject {
    @Published private(set) var items: [Record] = []
    private let key = "abyss.records.v2"

    init() { load() }

    func add(_ r: Record) {
        items.insert(r, at: 0)
        if items.count > 100 { items = Array(items.prefix(100)) }
        save()
    }

    func clear() {
        items = []
        save()
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Record].self, from: data) else { return }
        items = decoded
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
