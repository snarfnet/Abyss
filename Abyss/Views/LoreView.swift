import SwiftUI

struct LoreView: View {
    var body: some View {
        ZStack {
            VoidBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    SectionHeader(ja: "深淵の眼について", en: "The Abyss")
                        .padding(.top, 8)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("名も、姿も持たぬ古き眼。")
                            .font(.system(.headline, design: .serif))
                            .foregroundStyle(Abyss.pale)
                        Text("深淵の底から、あなたの問いを見つめ返す存在です。はい／いいえで答えられる問いを捧げると、然り、または否を告げ、古の英知の一言を添えます。")
                            .font(.system(.callout, design: .serif))
                            .foregroundStyle(Abyss.mist)
                        Text("A nameless, faceless eye that gazes back from the deep. Offer it a yes-or-no question and it answers 然り (yes) or 否 (no), adding a single line of ancient wisdom.")
                            .font(.system(size: 13, design: .serif))
                            .foregroundStyle(Abyss.dim)
                    }
                    .abyssCard()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("予言について")
                            .font(.system(.headline, design: .serif))
                            .foregroundStyle(Abyss.pale)
                        Text("「予言」では、眼は時の向こうを覗き、来たるべきものの兆しを告げます。デルポイやシビュラの神託の作法にならった、暗号めいた言葉と予兆のしるしです。")
                            .font(.system(.callout, design: .serif))
                            .foregroundStyle(Abyss.mist)
                    }
                    .abyssCard()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("英知の出典")
                            .font(.system(.headline, design: .serif))
                            .foregroundStyle(Abyss.pale)
                        Text("収録した言葉は、すべてパブリックドメインの古典に基づく私たちの簡潔な訳・再話です。老子・易経・論語・マルクス・アウレリウス・セネカ・エピクテトス・ヘラクレイトス・ホラティウス・箴言・デルポイの箴言・シビュラの託宣・エジプト／シュメールの格言ほか。")
                            .font(.system(size: 13, design: .serif))
                            .foregroundStyle(Abyss.mist)
                        Text("All lines are our own concise renderings of public-domain classics: Tao Te Ching, I Ching, Analects, Marcus Aurelius, Seneca, Epictetus, Heraclitus, Horace, Proverbs, the Delphic maxims, the Sibylline oracles, and Egyptian/Sumerian sayings.")
                            .font(.system(size: 12, design: .serif))
                            .foregroundStyle(Abyss.dim)
                    }
                    .abyssCard()

                    Text("これは娯楽のためのアプリです。占いの結果は古典の言葉を借りた演出であり、助言や予測を保証するものではありません。\nFor entertainment. Not advice or prediction.")
                        .font(.system(size: 11))
                        .foregroundStyle(Abyss.dim)
                        .padding(.top, 4)
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 24)
            }
        }
    }
}
