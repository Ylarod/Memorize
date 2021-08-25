//
//  ContentView.swift
//  Memorize
//
//  Created by Ylarod on 2021/8/20.
//

import SwiftUI

var emojisVehicles = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🦽", "🦼", "🛴", "🚲", "🛵", "🏍", "🛺", "🚝", "🚄", "🚅"]
var emojisBuildings = ["🏰", "🏯", "🏠", "🏡", "🏘", "🏚", "🏭", "🏢", "🏬", "🏣", "🏤", "🏥", "🏦", "🏨", "🏪", "🏫", "🏩", "💒", "⛪️", "🕌", "🕍", "🛕", "🏛", "⛩"]
var emojisCountries = ["🇨🇳", "🇺🇳", "🇦🇱", "🇩🇿", "🇦🇫", "🇦🇷", "🇦🇪", "🇦🇼", "🇴🇲", "🇦🇿", "🇪🇬", "🇪🇹", "🇮🇪", "🇪🇪", "🇦🇩", "🇦🇴", "🇦🇴", "🇦🇮", "🇦🇬", "🇦🇹", "🇦🇽", "🇦🇺", "🇲🇴", "🇧🇧"]

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    
    var body: some View {
        VStack {
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}

struct CardView : View {
    let card: MemoryGame<String>.Card
    
    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3.0)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched{
                shape.opacity(0)
            } else{
                shape.fill().foregroundColor(.red)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
