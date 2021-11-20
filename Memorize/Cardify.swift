//
//  Cardify.swift
//  Memorize
//
//  Created by Ylarod on 2021/11/20.
//

import SwiftUI

struct Cardify: AnimatableModifier{
    var color: Color
    var rotation: Double // in degrees
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue}
    }
    
    init(isFaceUp: Bool, color: Color){
        self.rotation = isFaceUp ? 0 : 180
        self.color = color
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else{
                shape.fill().foregroundColor(color)
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 20.0
        static let lineWidth: CGFloat = 3.0
    }
}

extension View {
    func cardify(isFaceUp: Bool, color: Color) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp, color: color))
    }
}
