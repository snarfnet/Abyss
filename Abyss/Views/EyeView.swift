import SwiftUI

/// The great eye of the abyss, drawn with Canvas. It breathes slowly and the
/// pupil constricts while the abyss considers a question.
struct AbyssEye: View {
    /// 0 = resting, 1 = fully focused (pupil small, iris bright)
    var focus: Double
    /// drives the slow ambient breathing / shimmer
    var phase: Double

    var body: some View {
        Canvas { ctx, size in
            let c = CGPoint(x: size.width / 2, y: size.height / 2)
            let R = min(size.width, size.height) / 2

            // ambient breathing
            let breathe = 1 + 0.02 * sin(phase * 2 * .pi)
            let irisR = R * 0.62 * breathe
            let pupilR = irisR * (0.42 - 0.20 * focus)

            // outer aura
            ctx.fill(
                Path(ellipseIn: CGRect(x: c.x - R, y: c.y - R, width: R * 2, height: R * 2)),
                with: .radialGradient(
                    Gradient(colors: [
                        Abyss.glow.opacity(0.22 + 0.20 * focus),
                        Abyss.iris.opacity(0.05),
                        .clear
                    ]),
                    center: c, startRadius: irisR * 0.6, endRadius: R
                )
            )

            // iris body
            let irisRect = CGRect(x: c.x - irisR, y: c.y - irisR, width: irisR * 2, height: irisR * 2)
            ctx.fill(
                Path(ellipseIn: irisRect),
                with: .radialGradient(
                    Gradient(stops: [
                        .init(color: Abyss.irisHi.opacity(0.9), location: 0.0),
                        .init(color: Abyss.iris, location: 0.45),
                        .init(color: Abyss.irisDeep, location: 0.85),
                        .init(color: Abyss.ink, location: 1.0),
                    ]),
                    center: c, startRadius: pupilR, endRadius: irisR
                )
            )

            // radial fibres of the iris
            let fibres = 64
            for i in 0..<fibres {
                let a = Double(i) / Double(fibres) * 2 * .pi
                let jitter = 0.86 + 0.14 * sin(a * 7 + phase * 2 * .pi)
                var p = Path()
                p.move(to: CGPoint(x: c.x + cos(a) * pupilR * 1.02,
                                   y: c.y + sin(a) * pupilR * 1.02))
                p.addLine(to: CGPoint(x: c.x + cos(a) * irisR * jitter,
                                      y: c.y + sin(a) * irisR * jitter))
                ctx.stroke(p, with: .color(Abyss.irisHi.opacity(0.16)), lineWidth: 0.7)
            }

            // limbal ring
            ctx.stroke(Path(ellipseIn: irisRect),
                       with: .color(Abyss.irisDeep.opacity(0.9)), lineWidth: 2)

            // pupil
            let pupilRect = CGRect(x: c.x - pupilR, y: c.y - pupilR, width: pupilR * 2, height: pupilR * 2)
            ctx.fill(Path(ellipseIn: pupilRect),
                     with: .radialGradient(
                        Gradient(colors: [Abyss.ink, .black]),
                        center: c, startRadius: 0, endRadius: pupilR))
            ctx.stroke(Path(ellipseIn: pupilRect),
                       with: .color(Abyss.glow.opacity(0.35 + 0.4 * focus)), lineWidth: 1.2)

            // catchlight
            let hl = pupilR * 0.5
            let hlp = CGPoint(x: c.x - pupilR * 0.35, y: c.y - pupilR * 0.42)
            ctx.fill(
                Path(ellipseIn: CGRect(x: hlp.x - hl / 2, y: hlp.y - hl / 2, width: hl, height: hl)),
                with: .color(Abyss.pale.opacity(0.5 + 0.3 * focus))
            )
        }
        .drawingGroup()
    }
}
