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
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(game.cards) { card in
                        CardView(card: card, color: game.color).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
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
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched{
                    shape.opacity(0)
                } else{
                    shape.fill().foregroundColor(color)
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.height, size.width) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 20.0
        static let lineWidth: CGFloat = 3.0
        static let fontScale: CGFloat = 0.8
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
