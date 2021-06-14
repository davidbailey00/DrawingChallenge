//
//  ContentView.swift
//  DrawingChallenge
//
//  Created by David Bailey on 14/06/2021.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        path.addRect(
            CGRect(
                x: 0.25 * rect.maxX,
                y: rect.midY,
                width: 0.5 * rect.width,
                height: 0.5 * rect.height
            )
        )

        return path
    }
}

struct ContentView: View {
    var body: some View {
        Arrow()
            .frame(width: 150, height: 150)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
