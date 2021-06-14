//
//  ContentView.swift
//  DrawingChallenge
//
//  Created by David Bailey on 14/06/2021.
//

import SwiftUI

struct Arrow: Shape {
    var lineThickness: CGFloat

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

struct ContentView: View {
    @State private var lineThickness: CGFloat = 0.5

    var body: some View {
        VStack {
            Arrow(lineThickness: lineThickness)
                .frame(width: 150, height: 150)
                .padding(.bottom)

            HStack {
                Text("Line thickness")
                Slider(value: $lineThickness)
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
