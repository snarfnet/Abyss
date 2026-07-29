import SwiftUI

struct DailyView: View {
    @State private var focus: Double = 0
    @State private var phase: Double = 0
    @State private var revealed = ProcessInfo.processInfo.arguments.contains("SCREENSHOT_MODE_2")

    private let today = OracleData.daily()
    private let breathe = Timer.publish(every: 1.0 / 30, on: .main, in: .common).autoconnect()

    private var dateLabel: String {
        let f = DateFormatter()
        f.dateFormat = "yyyy.MM.dd"
        return f.string(from: Date())
    }

    var body: some View {
        ZStack {
            VoidBackground()
            VStack(spacing: 0) {
                Spacer(minLength: 8)

                Text(dateLabel)
                    .font(.system(size: 12, weight: .medium)).tracking(3)
                    .foregroundStyle(Abyss.dim)

                AbyssEye(focus: focus, phase: phase)
                    .frame(width: 230, height: 230)
                    .onTapGesture { reveal() }

                revealArea
                    .frame(minHeight: 190)
                    .padding(.horizontal, 26)

                Spacer(minLength: 8)

                if !revealed {
                    Button(action: reveal) {
                        Text("今日の言葉を開く")
                            .font(.system(.headline, design: .serif))
                            .foregroundStyle(Abyss.void)
                            .frame(maxWidth: .infinity).padding(.vertical, 15)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Abyss.irisHi))
                    }
                    .padding(.horizontal, 24).padding(.bottom, 10)
                }
            }
        }
        .onReceive(breathe) { _ in phase += 1.0 / 30 / 6 }
        .onAppear {
            if revealed { withAnimation(.easeInOut(duration: 1.2)) { focus = 0.7 } }
        }
    }

    @ViewBuilder private var revealArea: some View {
        if revealed {
            VStack(spacing: 14) {
                Text("本日の一句 · Today")
                    .font(.system(size: 11)).tracking(2)
                    .foregroundStyle(Abyss.dim)
                VStack(spacing: 8) {
                    Text("「\(today.ja)」")
                        .font(.system(.title3, design: .serif))
                        .foregroundStyle(Abyss.pale)
                        .multilineTextAlignment(.center)
                    Text(today.en)
                        .font(.system(size: 13, design: .serif).italic())
                        .foregroundStyle(Abyss.mist.opacity(0.85))
                        .multilineTextAlignment(.center)
                }
                Text("— \(today.source)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Abyss.glow)
            }
            .transition(.opacity.combined(with: .scale(scale: 0.94)))
        } else {
            Text("眼に触れ、今日の一句を受け取れ")
                .font(.system(.callout, design: .serif))
                .foregroundStyle(Abyss.dim)
        }
    }

    private func reveal() {
        guard !revealed else { return }
        withAnimation(.easeInOut(duration: 1.4)) { focus = 1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) { revealed = true }
            withAnimation(.easeInOut(duration: 1.2)) { focus = 0.7 }
        }
    }
}
