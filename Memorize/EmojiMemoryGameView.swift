//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ylarod on 2021/8/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    
    var body: some View {
        VStack {
            Text(game.title).font(.largeTitle)
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                }else {
                    CardView(card: card, color: game.color)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            })
            .foregroundColor(game.color)
            Spacer()
            HStack{
                newGame
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var newGame : some View{
        Button {
            game.newGame()
        } label: {
            VStack{
                Image(systemName: "plus.square.fill")
            }
        }
    }
        
}

struct CardView : View {
    let card: EmojiMemoryGame.Card
    let color: Color
    
    var body: some View{
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5)
                    .opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, color: color)
//            .animation(.spring())
        }
    }
    
    private func scale(thatFits size:CGSize) -> CGFloat {
        min(size.width, size.height) * DrawingConstants.fontScale / DrawingConstants.fontSize
    }
    
    private struct DrawingConstants{
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
//        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
//        EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.dark)
    }
}
