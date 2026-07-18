import SwiftUI

/// Palette: the void (near-black) with a cold blue iris and pale astral light.
enum Abyss {
    static let void = Color(red: 0.02, green: 0.03, blue: 0.06)
    static let voidHi = Color(red: 0.05, green: 0.07, blue: 0.12)
    static let ink = Color(red: 0.01, green: 0.02, blue: 0.04)

    static let iris = Color(red: 0.24, green: 0.52, blue: 0.90)
    static let irisHi = Color(red: 0.46, green: 0.74, blue: 1.0)
    static let irisDeep = Color(red: 0.10, green: 0.26, blue: 0.58)

    static let glow = Color(red: 0.36, green: 0.66, blue: 1.0)
    static let mist = Color(red: 0.62, green: 0.74, blue: 0.92)
    static let pale = Color(red: 0.82, green: 0.88, blue: 0.98)
    static let dim = Color(red: 0.40, green: 0.48, blue: 0.62)
}

/// Deep radial void background.
struct VoidBackground: View {
    var body: some View {
        ZStack {
            Abyss.void.ignoresSafeArea()
            RadialGradient(
                colors: [Abyss.voidHi, Abyss.void, Abyss.ink],
                center: .center, startRadius: 20, endRadius: 620
            )
            .ignoresSafeArea()
        }
    }
}

/// Card styled like a slab of dark glass rimmed in faint blue.
struct AbyssCard<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Abyss.voidHi.opacity(0.55))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Abyss.iris.opacity(0.22), lineWidth: 1)
            )
    }
}

extension View {
    func abyssCard() -> some View { AbyssCard { self } }
}

/// Bilingual section header.
struct SectionHeader: View {
    let ja: String
    let en: String
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(ja)
                .font(.system(.title3, design: .serif).weight(.semibold))
                .foregroundStyle(Abyss.pale)
            Text(en.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .tracking(3)
                .foregroundStyle(Abyss.dim)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
