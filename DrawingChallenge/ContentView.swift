//
//  ContentView.swift
//  DrawingChallenge
//
//  Created by David Bailey on 14/06/2021.
//

import SwiftUI

struct Arrow: Shape {
    var lineThickness: CGFloat

    var animatableData: CGFloat {
        get { lineThickness }
        set { lineThickness = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        path.addRect(
            CGRect(
                x: 0.5 * (1 - lineThickness) * rect.maxX,
                y: rect.midY,
                width: lineThickness * rect.width,
                height: 0.5 * rect.height
            )
        )

        return path
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0 ..< steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    self.color(for: value, offset: 0),
                                    self.color(for: value, offset: 0.25)
                                ]
                            ),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, offset: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount + offset

        while targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: 1)
    }
}

struct ContentView: View {
    @State private var lineThickness: CGFloat = 0.25
    @State private var colorCycle = 0.0

    var body: some View {
        VStack(spacing: 64) {
            VStack {
                Arrow(lineThickness: lineThickness)
                    .frame(width: 150, height: 150)
                    .padding(.bottom)

                Button("Toggle line thickness") {
                    withAnimation {
                        if lineThickness == 0.75 {
                            lineThickness = 0.25
                        } else {
                            lineThickness = 0.75
                        }
                    }
                }
            }

            VStack {
                ColorCyclingRectangle(amount: colorCycle)
                    .frame(width: 250, height: 250)
                    .padding(.bottom)

                Slider(value: $colorCycle)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
