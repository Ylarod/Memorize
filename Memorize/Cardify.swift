//
//  Cardify.swift
//  Memorize
//
//  Created by Ylarod on 2021/11/20.
//

import SwiftUI

struct Cardify: ViewModifier{
    var isFaceUp: Bool
    var color: Color
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else{
                shape.fill().foregroundColor(color)
            }
            content.opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 20.0
        static let lineWidth: CGFloat = 3.0
    }
}

extension View {
    func cardify(isFaceUp: Bool, color: Color = .red) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp, color: color))
    }
}
