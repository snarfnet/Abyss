import SwiftUI

struct ProphecyView: View {
    @EnvironmentObject var records: RecordStore
    @State private var focus: Double = 0
    @State private var phase: Double = 0
    @State private var gazing = false
    @State private var prophecy: Prophecy?

    private let breathe = Timer.publish(every: 1.0 / 30, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            VoidBackground()
            VStack(spacing: 0) {
                Spacer(minLength: 8)

                AbyssEye(focus: focus, phase: phase)
                    .frame(width: 230, height: 230)
                    .overlay(alignment: .center) {
                        if gazing {
                            Image(systemName: "sparkles")
                                .font(.system(size: 22))
                                .foregroundStyle(Abyss.pale.opacity(0.7))
                                .offset(y: -2)
                        }
                    }
                    .onTapGesture { gaze() }

                revealArea
                    .frame(minHeight: 210)
                    .padding(.horizontal, 26)

                Spacer(minLength: 8)

                Button(action: gaze) {
                    Text(prophecy == nil ? "未来を覗く" : "もう一度覗く")
                        .font(.system(.headline, design: .serif))
                        .foregroundStyle(Abyss.void)
                        .frame(maxWidth: .infinity).padding(.vertical, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(gazing ? Abyss.dim : Abyss.irisHi)
                        )
                }
                .disabled(gazing)
                .padding(.horizontal, 24).padding(.bottom, 10)
            }
        }
        .onReceive(breathe) { _ in phase += 1.0 / 30 / 6 }
        .onAppear {
            if ProcessInfo.processInfo.arguments.contains("SCREENSHOT_MODE_2") { gaze() }
        }
    }

    @ViewBuilder private var revealArea: some View {
        if let p = prophecy, !gazing {
            VStack(spacing: 16) {
                VStack(spacing: 6) {
                    Image(systemName: p.omen)
                        .font(.system(size: 30))
                        .foregroundStyle(Abyss.irisHi)
                        .shadow(color: Abyss.glow.opacity(0.6), radius: 12)
                    Text("\(p.signJa) · \(p.signEn)")
                        .font(.system(size: 11)).tracking(2)
                        .foregroundStyle(Abyss.dim)
                }
                VStack(spacing: 8) {
                    Text(p.ja)
                        .font(.system(.title3, design: .serif))
                        .foregroundStyle(Abyss.pale)
                        .multilineTextAlignment(.center)
                    Text(p.en)
                        .font(.system(size: 13, design: .serif).italic())
                        .foregroundStyle(Abyss.mist.opacity(0.85))
                        .multilineTextAlignment(.center)
                }
                Text("\(p.whenJa) — \(p.whenEn)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Abyss.glow)
            }
            .transition(.opacity.combined(with: .scale(scale: 0.94)))
        } else if gazing {
            Text("眼が、時の向こうを覗いている…")
                .font(.system(.callout, design: .serif))
                .foregroundStyle(Abyss.mist)
        } else {
            Text("眼に触れ、来たるべきものを問え")
                .font(.system(.callout, design: .serif))
                .foregroundStyle(Abyss.dim)
        }
    }

    private func gaze() {
        withAnimation(.easeOut(duration: 0.3)) { prophecy = nil; gazing = true }
        withAnimation(.easeInOut(duration: 1.6)) { focus = 1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
            let p = OracleData.foresee()
            withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) {
                prophecy = p; gazing = false
            }
            withAnimation(.easeInOut(duration: 1.2)) { focus = 0 }
            records.add(Record(kind: .prophecy, question: "", answer: "",
                               lineJa: p.ja, lineEn: p.en, source: p.source))
        }
    }
}
