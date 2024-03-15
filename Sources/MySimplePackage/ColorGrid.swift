//
//  SwiftUIView.swift
//  
//
//  Created by Pinxuan Huang on 3/15/24.
//

import SwiftUI
import Colorful

struct ColorSquare: View {
    let color: SwiftUI.Color
    var body: some View {
        color
        .frame(width: 50, height: 50)
    }
}

@available(iOS 16.0, *)
public struct ColorGrid: View {
    let ROWS = 3
    let COLS = 3
    let DEFAULT_COLOR = SwiftUI.Color.gray
    @State private var gridColors: [SwiftUI.Color] = []

    public init() {}

    public var body: some View {
        // TODO - display a grid of 6 colors
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<ROWS, id: \.self) {i in
                GridRow {
                    ForEach(0..<COLS, id: \.self) {j in
                        ColorSquare(color: getGridColor(row: i, col: j))
                    }
                }
            }
        }
        .onAppear() {
            gridColors = try! bakeBrownie()
        }
    }

    func isBrowny(l: Float64, a: Float64, b: Float64) -> Bool {
        let (h, c, L) = Color.LabToHcl(L: l, a: a, b: b)
        return 10.0 < h && h < 50.0 && 0.1 < c && c < 0.5 && L < 0.5
    }

    func bakeBrownie() throws -> [SwiftUI.Color] {
        do {
            let brownies = try SoftPaletteEx(colorsCount: ROWS * COLS, settings: SoftPaletteSettings(checkColorFn: isBrowny, iterations: 50, manySamples: true))
            return brownies.map({toSwiftUIColor(color: $0)})
        } catch {
            throw error
        }
    }

    func toSwiftUIColor(color: Colorful.Color) -> SwiftUI.Color {
        let (r, g, b) = color.Values()
        return SwiftUI.Color(red: r, green: g, blue: b)
    }

    func getGridColor(row: Int, col: Int) -> SwiftUI.Color {
        let k = row * ROWS + col
        return gridColors.indices.contains(k) ? gridColors[k] : DEFAULT_COLOR
    }
}

@available(iOS 16.0, *)
struct ColorGrid_Previews: PreviewProvider {
    static var previews: some View {
        ColorGrid()
    }
}
