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
                        Text("「深淵を覗くとき、深淵もまた汝を覗いている」")
                            .font(.system(.headline, design: .serif))
                            .foregroundStyle(Abyss.pale)
                        Text("ニーチェのこの言葉から生まれた、古典哲学の内省リーダーです。心にある問いや迷いを書き留め、眼に触れると、老子・セネカ・マルクス・アウレリウスら古の思索家の一節が映し出されます。答えを授かるのではなく、その言葉を通して自分自身を見つめ直すための道具です。")
                            .font(.system(.callout, design: .serif))
                            .foregroundStyle(Abyss.mist)
                        Text("A reflection reader built on classical philosophy, born from Nietzsche's line. Write down a question or hesitation, touch the eye, and a passage from Laozi, Seneca, Marcus Aurelius and other ancient thinkers appears — not an answer given, but a mirror to look at yourself.")
                            .font(.system(size: 13, design: .serif))
                            .foregroundStyle(Abyss.dim)
                    }
                    .abyssCard()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("今日の一句")
                            .font(.system(.headline, design: .serif))
                            .foregroundStyle(Abyss.pale)
                        Text("「今日」タブでは、日ごとに一つの古典の言葉が選ばれます。今日という日を、一節とともに始めるために。")
                            .font(.system(.callout, design: .serif))
                            .foregroundStyle(Abyss.mist)
                    }
                    .abyssCard()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("英知の出典")
                            .font(.system(.headline, design: .serif))
                            .foregroundStyle(Abyss.pale)
                        Text("収録した言葉は、すべてパブリックドメインの古典に基づく私たちの簡潔な訳・再話です。老子・易経・論語・マルクス・アウレリウス・セネカ・エピクテトス・ヘラクレイトス・ホラティウス・ニーチェ・箴言・デルポイの箴言・エジプト／シュメールの格言ほか。")
                            .font(.system(size: 13, design: .serif))
                            .foregroundStyle(Abyss.mist)
                        Text("All lines are our own concise renderings of public-domain classics: Tao Te Ching, I Ching, Analects, Marcus Aurelius, Seneca, Epictetus, Heraclitus, Horace, Nietzsche, Proverbs, the Delphic maxims, and Egyptian/Sumerian sayings.")
                            .font(.system(size: 12, design: .serif))
                            .foregroundStyle(Abyss.dim)
                    }
                    .abyssCard()

                    Text("これは古典の言葉に触れ、自らを省みるためのアプリです。表示される一節は運勢や未来の予測ではありません。\nA tool for reflection through classical wisdom. Not fortune-telling or prediction.")
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
