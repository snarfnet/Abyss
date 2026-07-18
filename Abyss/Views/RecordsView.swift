import SwiftUI

struct RecordsView: View {
    @EnvironmentObject var records: RecordStore
    @State private var confirmClear = false

    private var df: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "M/d HH:mm"
        return f
    }

    var body: some View {
        ZStack {
            VoidBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    SectionHeader(ja: "記録", en: "The Ledger")
                        .padding(.top, 8)

                    if records.items.isEmpty {
                        Text("まだ深淵に問うていない。")
                            .font(.system(.callout, design: .serif))
                            .foregroundStyle(Abyss.dim)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 60)
                    } else {
                        ForEach(records.items) { r in
                            row(r)
                        }
                        Button(role: .destructive) { confirmClear = true } label: {
                            Text("すべて消す").font(.footnote)
                                .frame(maxWidth: .infinity)
                        }
                        .tint(Abyss.dim)
                        .padding(.top, 8)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 24)
            }
        }
        .alert("記録をすべて消しますか？", isPresented: $confirmClear) {
            Button("消す", role: .destructive) { records.clear() }
            Button("やめる", role: .cancel) {}
        }
    }

    @ViewBuilder private func row(_ r: Record) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Label(r.kind == .consult ? "問い" : "予言",
                      systemImage: r.kind == .consult ? "eye" : "sparkles")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Abyss.glow)
                Spacer()
                Text(df.string(from: r.date))
                    .font(.system(size: 11)).foregroundStyle(Abyss.dim)
            }
            if r.kind == .consult {
                Text(r.question)
                    .font(.system(.subheadline, design: .serif))
                    .foregroundStyle(Abyss.pale)
                Text(r.answer)
                    .font(.system(size: 22, weight: .bold, design: .serif))
                    .foregroundStyle(r.answer == "然り" ? Abyss.irisHi : Abyss.mist)
            }
            Text("「\(r.lineJa)」")
                .font(.system(.footnote, design: .serif))
                .foregroundStyle(Abyss.mist)
            Text("— \(r.source)")
                .font(.system(size: 10)).foregroundStyle(Abyss.dim)
        }
        .abyssCard()
    }
}
