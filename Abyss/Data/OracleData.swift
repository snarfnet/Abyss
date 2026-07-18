import Foundation

struct Verdict {
    let yes: Bool
    var ja: String { yes ? "然り" : "否" }
    var en: String { yes ? "YES" : "NO" }
}

/// A single line of ancient wisdom. `affirms` marks it as encouraging (paired
/// with 然り) or cautioning (paired with 否). All lines are our own concise
/// renderings of public-domain sources.
struct OracleLine {
    let ja: String
    let en: String
    let source: String
    let affirms: Bool
}

/// A glimpse of what is to come, in the manner of the old oracles.
struct Prophecy {
    let ja: String
    let en: String
    let omen: String      // SF Symbol name for the sign
    let signJa: String
    let signEn: String
    let whenJa: String
    let whenEn: String
    let source: String
}

enum OracleData {

    // MARK: Encouraging lines (然り / YES)
    static let affirming: [OracleLine] = [
        .init(ja: "千里の道も、足下の一歩から。", en: "A journey of a thousand li begins beneath your feet.", source: "老子", affirms: true),
        .init(ja: "太陽は、日ごとに新しい。", en: "The sun is new again each day.", source: "ヘラクレイトス", affirms: true),
        .init(ja: "貞しくあれば、通る。", en: "Perseverance furthers.", source: "易経", affirms: true),
        .init(ja: "大いなる川を、渉るによし。", en: "It furthers one to cross the great water.", source: "易経", affirms: true),
        .init(ja: "始めた者は、事の半ばを終えている。", en: "Who has begun is already half done.", source: "ホラティウス", affirms: true),
        .init(ja: "汝の道を、進むがよい。", en: "Walk on — the path is yours.", source: "デルポイの箴言", affirms: true),
        .init(ja: "機を得たなら、掴め。", en: "When the moment offers its hand, take it.", source: "セネカ", affirms: true),
        .init(ja: "水は低きに流れ、やがて海に至る。", en: "Water yields, and so it reaches the sea.", source: "老子", affirms: true),
        .init(ja: "為すべきことを為せ。結果は後からついてくる。", en: "Do what is yours to do; the rest follows.", source: "マルクス・アウレリウス", affirms: true),
        .init(ja: "種を蒔く者は、刈り取る時を知る。", en: "The one who sows knows the season of the harvest.", source: "箴言", affirms: true),
        .init(ja: "恐れは、ただ影にすぎない。", en: "Fear is only a shadow cast forward.", source: "エピクテトス", affirms: true),
        .init(ja: "柔らかきものが、硬きものに勝つ。", en: "The soft overcomes the hard.", source: "老子", affirms: true),
        .init(ja: "光を求める者に、闇は道を空ける。", en: "To the one who seeks light, the dark makes way.", source: "シビュラの託宣", affirms: true),
        .init(ja: "己を知る者は、迷わない。", en: "Who knows himself does not stray.", source: "デルポイの箴言", affirms: true),
        .init(ja: "今日という日を、掴め。", en: "Seize the day.", source: "ホラティウス", affirms: true),
        .init(ja: "岩をも穿つは、絶えざる滴。", en: "The steady drop hollows the stone.", source: "オウィディウス", affirms: true),
        .init(ja: "追い風は、帆を張る者にのみ吹く。", en: "The fair wind favors the sail already raised.", source: "エジプトの格言", affirms: true),
        .init(ja: "善き行いは、決して失われない。", en: "A good deed is never lost.", source: "セネカ", affirms: true),
        .init(ja: "扉を叩けば、開かれる。", en: "Knock, and it opens.", source: "箴言", affirms: true),
        .init(ja: "夜明けは、最も暗き時のあとに来る。", en: "Dawn comes after the deepest dark.", source: "シュメールの格言", affirms: true),
    ]

    // MARK: Cautioning lines (否 / NO)
    static let cautioning: [OracleLine] = [
        .init(ja: "急ぐ足は、道を誤る。", en: "Hasty feet mistake the road.", source: "箴言", affirms: false),
        .init(ja: "満ちれば、欠ける。", en: "What is full begins to wane.", source: "易経", affirms: false),
        .init(ja: "止まるを知れば、危うくない。", en: "Know when to stop, and you meet no danger.", source: "老子", affirms: false),
        .init(ja: "熟さぬ実は、もぐな。", en: "Do not pluck the fruit before its time.", source: "エジプトの格言", affirms: false),
        .init(ja: "多くを望む者は、多くを失う。", en: "He who wants much loses much.", source: "セネカ", affirms: false),
        .init(ja: "退くもまた、進むこと。", en: "To withdraw is also to advance.", source: "易経", affirms: false),
        .init(ja: "沈黙のうちに、時を待て。", en: "Wait in silence for the hour.", source: "エピクテトス", affirms: false),
        .init(ja: "過ぎたるは、及ばざるがごとし。", en: "Too much is as bad as too little.", source: "論語", affirms: false),
        .init(ja: "浅き瀬を、深いと侮るな。", en: "Do not trust the shallow ford as deep.", source: "デルポイの箴言", affirms: false),
        .init(ja: "怒りのうちに、舵を取るな。", en: "Do not steer while the storm of anger holds you.", source: "マルクス・アウレリウス", affirms: false),
        .init(ja: "その門は、まだ汝のためには開かぬ。", en: "That gate does not yet open for you.", source: "シビュラの託宣", affirms: false),
        .init(ja: "影が長く伸びる。今は動くな。", en: "The shadows lengthen — do not move now.", source: "シビュラの託宣", affirms: false),
        .init(ja: "借りた翼では、遠くへ飛べぬ。", en: "Borrowed wings carry no one far.", source: "イソップ", affirms: false),
        .init(ja: "近道は、しばしば最も長い道。", en: "The shortcut is often the longest road.", source: "シュメールの格言", affirms: false),
        .init(ja: "口を慎め。言葉は矢に似て、戻らぬ。", en: "Guard your mouth; a word, like an arrow, does not return.", source: "箴言", affirms: false),
        .init(ja: "求めすぎる手からは、すべてこぼれる。", en: "The grasping hand spills all it holds.", source: "老子", affirms: false),
        .init(ja: "夜に急ぐ旅人は、道を見失う。", en: "Who hurries through the night loses the path.", source: "エジプトの格言", affirms: false),
        .init(ja: "疑いを抱いたまま、渡るな。", en: "Do not cross while doubt is still in you.", source: "論語", affirms: false),
        .init(ja: "運命の糸は、まだ結ばれていない。", en: "The thread of fate is not yet tied.", source: "シビュラの託宣", affirms: false),
        .init(ja: "静けさの中にこそ、答えは兆す。", en: "The answer stirs only in stillness — not yet.", source: "ヘラクレイトス", affirms: false),
    ]

    // MARK: Prophecies (未来を覗く / Foresee)
    static let prophecies: [Prophecy] = [
        .init(ja: "遠くから来る一つの報せが、汝の道を分ける。",
              en: "A message from afar will divide your road.",
              omen: "envelope", signJa: "報せ", signEn: "A messenger",
              whenJa: "月が満ちる前に", whenEn: "before the moon is full", source: "シビュラの託宣"),
        .init(ja: "古き扉が閉じ、見知らぬ扉が軋みながら開く。",
              en: "An old door closes; an unknown one creaks open.",
              omen: "door.left.hand.open", signJa: "扉", signEn: "A threshold",
              whenJa: "季節が変わる頃", whenEn: "as the season turns", source: "デルポイの託宣"),
        .init(ja: "水辺で、忘れていた顔に再び出会う。",
              en: "By the water you will meet a face long forgotten.",
              omen: "drop", signJa: "水", signEn: "Still water",
              whenJa: "三度の日の出のうちに", whenEn: "within three sunrises", source: "シビュラの託宣"),
        .init(ja: "小さな種が、汝の思うより大きく育つ。",
              en: "A small seed will grow larger than you dream.",
              omen: "leaf", signJa: "芽吹き", signEn: "A green shoot",
              whenJa: "次の満月まで", whenEn: "by the next full moon", source: "エジプトの託宣"),
        .init(ja: "背後の炎は、やがて温もりに変わる。",
              en: "The fire behind you will turn to warmth.",
              omen: "flame", signJa: "炎", signEn: "A distant fire",
              whenJa: "冬が明ける頃", whenEn: "as winter breaks", source: "ヘラクレイトス"),
        .init(ja: "旅路の途中、名を呼ぶ声に振り向くな。まだ時ではない。",
              en: "On the road a voice will call your name — do not yet turn.",
              omen: "figure.walk", signJa: "旅路", signEn: "A crossroad",
              whenJa: "七つの夜のうちに", whenEn: "within seven nights", source: "シビュラの託宣"),
        .init(ja: "失くしたと思ったものが、思わぬ手から返ってくる。",
              en: "What you thought lost returns by an unexpected hand.",
              omen: "hands.and.sparkles", signJa: "返還", signEn: "A returning",
              whenJa: "月が欠けるうちに", whenEn: "while the moon wanes", source: "エジプトの託宣"),
        .init(ja: "北からの風が、長く待った知らせを運ぶ。",
              en: "A wind from the north carries the news you have awaited.",
              omen: "wind", signJa: "北風", signEn: "The north wind",
              whenJa: "次の新月に", whenEn: "at the new moon", source: "デルポイの託宣"),
        .init(ja: "石の下に、汝のための道が眠っている。",
              en: "Beneath the stone a path for you lies sleeping.",
              omen: "mountain.2", signJa: "石", signEn: "A stone",
              whenJa: "やがて、静かに", whenEn: "in time, quietly", source: "シビュラの託宣"),
        .init(ja: "二つの光が交わる夜、選ぶべき道が示される。",
              en: "On the night two lights cross, your road is shown.",
              omen: "sparkles", signJa: "双つ星", signEn: "Twin lights",
              whenJa: "星が並ぶ夜に", whenEn: "when the stars align", source: "シビュラの託宣"),
        .init(ja: "沈黙のうちに育ったものが、声をあげる番が来る。",
              en: "What grew in silence will find its voice.",
              omen: "bell", signJa: "鐘", signEn: "A bell",
              whenJa: "まもなく", whenEn: "soon", source: "ヘラクレイトス"),
        .init(ja: "手放したとき、はじめて手に入るものがある。",
              en: "Only when you let go will it come to your hand.",
              omen: "hand.raised", signJa: "手放し", signEn: "An open hand",
              whenJa: "手放したその時に", whenEn: "the moment you release it", source: "老子の託宣"),
    ]

    // MARK: Engine

    /// The abyss gives the same verdict to the same question — as if it were fated.
    static func consult(_ question: String) -> (Verdict, OracleLine) {
        let key = normalize(question)
        let h = stableHash(key)
        let yes = (h & 1) == 0
        let pool = yes ? affirming : cautioning
        let line = pool[Int((h >> 1) % UInt64(pool.count))]
        return (Verdict(yes: yes), line)
    }

    /// Each gaze into the future is a fresh glimpse.
    static func foresee() -> Prophecy {
        prophecies.randomElement()!
    }

    private static func normalize(_ s: String) -> String {
        s.trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .replacingOccurrences(of: "　", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "?", with: "")
            .replacingOccurrences(of: "？", with: "")
    }

    /// FNV-1a — stable across launches (unlike Swift's per-run Hasher).
    private static func stableHash(_ s: String) -> UInt64 {
        var h: UInt64 = 1469598103934665603
        for b in s.utf8 {
            h ^= UInt64(b)
            h = h &* 1099511628211
        }
        return h
    }
}
