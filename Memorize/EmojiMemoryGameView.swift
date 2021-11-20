//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ylarod on 2021/8/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack {
                Text(game.title).font(.largeTitle)
                gameBody
                Spacer()
                HStack{
                    newGame
                    restart
                    shuffle
                }
                .font(.largeTitle)
                .padding(.horizontal)
            }
            deckBody.padding(.bottom, 50.0)
        }
        .padding(.horizontal)
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: {$0.id == card.id }){
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double{
        -Double(game.cards.firstIndex(where: {$0.id == card.id }) ?? 0)
    }
    
    var gameBody: some View{
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            }else {
                CardView(card: card, color: game.color)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        })
        .foregroundColor(game.color)
    }
    
    var deckBody: some View {
        ZStack{
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card, color: game.color)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }.onTapGesture {
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
    }
    
    var newGame : some View{
        Button {
            withAnimation {
                dealt.removeAll()
                game.newGame()
            }
        } label: {
            VStack{
                Image(systemName: "plus.square")
            }
        }
    }
    
    var restart: some View {
        Button {
            withAnimation {
                dealt.removeAll()
                game.restart()
            }
        } label: {
            VStack{
                Image(systemName: "memories")
            }
        }
        
    }
    var shuffle : some View{
        Button {
            withAnimation {
                game.shuffle()
            }
        } label: {
            VStack{
                Image(systemName: "shuffle.circle")
            }
        }
    }
    
    
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}

struct CardView : View {
    let card: EmojiMemoryGame.Card
    let color: Color
    
    @State var animatedBonusRemaining: Double = 0
    
    var body: some View{
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear{
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
                .opacity(0.5)
                .padding(5)
                
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, color: color)
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
