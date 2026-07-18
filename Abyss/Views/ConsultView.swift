import SwiftUI

struct ConsultView: View {
    @EnvironmentObject var records: RecordStore
    @State private var question = ProcessInfo.processInfo.arguments.contains("SCREENSHOT_MODE_1") ? "私はこの道を進むべきか？" : ""
    @State private var focus: Double = 0
    @State private var phase: Double = 0
    @State private var thinking = false
    @State private var verdict: Verdict?
    @State private var line: OracleLine?
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
        if let v = verdict, let l = line, !thinking {
            VStack(spacing: 14) {
                Text(v.ja)
                    .font(.system(size: 46, weight: .bold, design: .serif))
                    .foregroundStyle(v.yes ? Abyss.irisHi : Abyss.mist)
                    .shadow(color: Abyss.glow.opacity(0.6), radius: 18)
                Text(v.en)
                    .font(.system(size: 12, weight: .semibold)).tracking(6)
                    .foregroundStyle(Abyss.dim)
                VStack(spacing: 6) {
                    Text("「\(l.ja)」")
                        .font(.system(.callout, design: .serif))
                        .foregroundStyle(Abyss.pale)
                        .multilineTextAlignment(.center)
                    Text(l.en)
                        .font(.system(size: 12, design: .serif).italic())
                        .foregroundStyle(Abyss.mist.opacity(0.8))
                        .multilineTextAlignment(.center)
                    Text("— \(l.source)")
                        .font(.system(size: 11)).foregroundStyle(Abyss.dim)
                        .padding(.top, 2)
                }
            }
            .transition(.opacity.combined(with: .scale(scale: 0.94)))
        } else if thinking {
            Text("深淵が視ている…")
                .font(.system(.callout, design: .serif))
                .foregroundStyle(Abyss.mist)
                .transition(.opacity)
        } else {
            Text("問いを捧げ、眼に触れよ")
                .font(.system(.callout, design: .serif))
                .foregroundStyle(Abyss.dim)
        }
    }

    private var inputArea: some View {
        HStack(spacing: 10) {
            TextField("はい／いいえで答えられる問いを…", text: $question, axis: .vertical)
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
            verdict = nil; line = nil; thinking = true
        }
        withAnimation(.easeInOut(duration: 1.4)) { focus = 1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            let (v, l) = OracleData.consult(q)
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                verdict = v; line = l; thinking = false
            }
            withAnimation(.easeInOut(duration: 1.2)) { focus = 0 }
            records.add(Record(kind: .consult, question: q, answer: v.ja,
                               lineJa: l.ja, lineEn: l.en, source: l.source))
        }
    }
}
