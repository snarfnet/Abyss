import SwiftUI

struct ReflectView: View {
    @EnvironmentObject var records: RecordStore
    @State private var question = ProcessInfo.processInfo.arguments.contains("SCREENSHOT_MODE_1") ? "私は今、何を手放すべきだろう？" : ""
    @State private var focus: Double = 0
    @State private var phase: Double = 0
    @State private var thinking = false
    @State private var reflection: Reflection?
    @FocusState private var editing: Bool

    private let breathe = Timer.publish(every: 1.0 / 30, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            VoidBackground()
            VStack(spacing: 0) {
                Spacer(minLength: 8)

                AbyssEye(focus: focus, phase: phase)
                    .frame(width: 260, height: 260)
                    .onTapGesture { if canAsk { ask() } }

                revealArea
                    .frame(minHeight: 150)
                    .padding(.horizontal, 24)

                Spacer(minLength: 8)

                inputArea
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
            }
        }
        .onReceive(breathe) { _ in phase += 1.0 / 30 / 6 }
        .onAppear {
            if ProcessInfo.processInfo.arguments.contains("SCREENSHOT_MODE_1") { ask() }
        }
    }

    private var canAsk: Bool {
        !question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !thinking
    }

    @ViewBuilder private var revealArea: some View {
        if let r = reflection, !thinking {
            VStack(spacing: 10) {
                Text("「\(r.ja)」")
                    .font(.system(size: 22, weight: .semibold, design: .serif))
                    .foregroundStyle(Abyss.pale)
                    .multilineTextAlignment(.center)
                    .shadow(color: Abyss.glow.opacity(0.4), radius: 12)
                Text(r.en)
                    .font(.system(size: 13, design: .serif).italic())
                    .foregroundStyle(Abyss.mist.opacity(0.85))
                    .multilineTextAlignment(.center)
                Text("— \(r.source)")
                    .font(.system(size: 11)).foregroundStyle(Abyss.dim)
                    .padding(.top, 2)
            }
            .transition(.opacity.combined(with: .scale(scale: 0.94)))
        } else if thinking {
            Text("深淵が、汝を見つめ返している…")
                .font(.system(.callout, design: .serif))
                .foregroundStyle(Abyss.mist)
                .transition(.opacity)
        } else {
            Text("問いを書き、眼に触れよ")
                .font(.system(.callout, design: .serif))
                .foregroundStyle(Abyss.dim)
        }
    }

    private var inputArea: some View {
        HStack(spacing: 10) {
            TextField("心にある問いや迷いを…", text: $question, axis: .vertical)
                .textFieldStyle(.plain)
                .lineLimit(1...3)
                .focused($editing)
                .foregroundStyle(Abyss.pale)
                .padding(.horizontal, 14).padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Abyss.voidHi.opacity(0.6))
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Abyss.iris.opacity(0.3), lineWidth: 1))
                )
                .onSubmit { if canAsk { ask() } }

            Button {
                editing = false
                if canAsk { ask() }
            } label: {
                Image(systemName: "eye.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(canAsk ? Abyss.irisHi : Abyss.dim)
            }
            .disabled(!canAsk)
        }
    }

    private func ask() {
        editing = false
        let q = question.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return }
        withAnimation(.easeOut(duration: 0.3)) {
            reflection = nil; thinking = true
        }
        withAnimation(.easeInOut(duration: 1.4)) { focus = 1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            let r = OracleData.reflect(q)
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                reflection = r; thinking = false
            }
            withAnimation(.easeInOut(duration: 1.2)) { focus = 0 }
            records.add(Record(question: q, lineJa: r.ja, lineEn: r.en, source: r.source))
        }
    }
}
