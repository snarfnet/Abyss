import Foundation

/// A single line of classical wisdom, offered for reflection.
/// All lines are our own concise renderings of public-domain sources.
struct Reflection {
    let ja: String
    let en: String
    let source: String
}

enum OracleData {

    // MARK: Classical wisdom for reflection
    static let reflections: [Reflection] = [
        .init(ja: "千里の道も、足下の一歩から。", en: "A journey of a thousand li begins beneath your feet.", source: "老子"),
        .init(ja: "太陽は、日ごとに新しい。", en: "The sun is new again each day.", source: "ヘラクレイトス"),
        .init(ja: "貞しくあれば、通る。", en: "Perseverance furthers.", source: "易経"),
        .init(ja: "大いなる川を、渉るによし。", en: "It furthers one to cross the great water.", source: "易経"),
        .init(ja: "始めた者は、事の半ばを終えている。", en: "Who has begun is already half done.", source: "ホラティウス"),
        .init(ja: "汝の道を、進むがよい。", en: "Walk on — the path is yours.", source: "デルポイの箴言"),
        .init(ja: "機を得たなら、掴め。", en: "When the moment offers its hand, take it.", source: "セネカ"),
        .init(ja: "水は低きに流れ、やがて海に至る。", en: "Water yields, and so it reaches the sea.", source: "老子"),
        .init(ja: "為すべきことを為せ。結果は後からついてくる。", en: "Do what is yours to do; the rest follows.", source: "マルクス・アウレリウス"),
        .init(ja: "種を蒔く者は、刈り取る時を知る。", en: "The one who sows knows the season of the harvest.", source: "箴言"),
        .init(ja: "恐れは、ただ影にすぎない。", en: "Fear is only a shadow cast forward.", source: "エピクテトス"),
        .init(ja: "柔らかきものが、硬きものに勝つ。", en: "The soft overcomes the hard.", source: "老子"),
        .init(ja: "己を知る者は、迷わない。", en: "Who knows himself does not stray.", source: "デルポイの箴言"),
        .init(ja: "今日という日を、掴め。", en: "Seize the day.", source: "ホラティウス"),
        .init(ja: "岩をも穿つは、絶えざる滴。", en: "The steady drop hollows the stone.", source: "オウィディウス"),
        .init(ja: "善き行いは、決して失われない。", en: "A good deed is never lost.", source: "セネカ"),
        .init(ja: "夜明けは、最も暗き時のあとに来る。", en: "Dawn comes after the deepest dark.", source: "シュメールの格言"),
        .init(ja: "深淵を覗くとき、深淵もまた汝を覗いている。", en: "When you gaze into the abyss, the abyss gazes also into you.", source: "ニーチェ"),
        .init(ja: "急ぐ足は、道を誤る。", en: "Hasty feet mistake the road.", source: "箴言"),
        .init(ja: "満ちれば、欠ける。", en: "What is full begins to wane.", source: "易経"),
        .init(ja: "止まるを知れば、危うくない。", en: "Know when to stop, and you meet no danger.", source: "老子"),
        .init(ja: "熟さぬ実は、もぐな。", en: "Do not pluck the fruit before its time.", source: "エジプトの格言"),
        .init(ja: "多くを望む者は、多くを失う。", en: "He who wants much loses much.", source: "セネカ"),
        .init(ja: "退くもまた、進むこと。", en: "To withdraw is also to advance.", source: "易経"),
        .init(ja: "沈黙のうちに、時を待て。", en: "Wait in silence for the hour.", source: "エピクテトス"),
        .init(ja: "過ぎたるは、及ばざるがごとし。", en: "Too much is as bad as too little.", source: "論語"),
        .init(ja: "浅き瀬を、深いと侮るな。", en: "Do not trust the shallow ford as deep.", source: "デルポイの箴言"),
        .init(ja: "怒りのうちに、舵を取るな。", en: "Do not steer while the storm of anger holds you.", source: "マルクス・アウレリウス"),
        .init(ja: "借りた翼では、遠くへ飛べぬ。", en: "Borrowed wings carry no one far.", source: "イソップ"),
        .init(ja: "近道は、しばしば最も長い道。", en: "The shortcut is often the longest road.", source: "シュメールの格言"),
        .init(ja: "口を慎め。言葉は矢に似て、戻らぬ。", en: "Guard your mouth; a word, like an arrow, does not return.", source: "箴言"),
        .init(ja: "求めすぎる手からは、すべてこぼれる。", en: "The grasping hand spills all it holds.", source: "老子"),
        .init(ja: "疑いを抱いたまま、渡るな。", en: "Do not cross while doubt is still in you.", source: "論語"),
        .init(ja: "静けさの中にこそ、答えは兆す。", en: "The answer stirs only in stillness.", source: "ヘラクレイトス"),
        .init(ja: "汝自身を知れ。", en: "Know thyself.", source: "デルポイの箴言"),
        .init(ja: "度を越すなかれ。", en: "Nothing in excess.", source: "デルポイの箴言"),
        .init(ja: "変わらぬものは、変化のみ。", en: "The only constant is change.", source: "ヘラクレイトス"),
        .init(ja: "人は同じ川に、二度は入れない。", en: "No one steps in the same river twice.", source: "ヘラクレイトス"),
        .init(ja: "在るものを愛せ。それは汝に定められたもの。", en: "Love what is; it was woven for you.", source: "マルクス・アウレリウス"),
        .init(ja: "今日できることを、明日に延ばすな。", en: "Do not put off till tomorrow what today can hold.", source: "ヘシオドス"),
    ]

    // MARK: Engine

    /// The same question always draws the same line — as if it were meant for you.
    static func reflect(_ question: String) -> Reflection {
        let key = normalize(question)
        let h = stableHash(key)
        return reflections[Int(h % UInt64(reflections.count))]
    }

    /// One line for today, the same for everyone on this date.
    static func daily(_ date: Date = Date()) -> Reflection {
        let day = Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 1
        return reflections[day % reflections.count]
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
