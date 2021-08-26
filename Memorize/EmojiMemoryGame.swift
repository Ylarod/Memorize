//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ylarod on 2021/8/24.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    
    static var themes = [
        Theme<String>(name: "Halloween", displayCount: 4, color: "blue", contents: ["👻","🎃", "🕷"]),
        Theme<String>(name: "Vehicles", displayCount: 6, color: "red", contents: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🦽", "🦼", "🛴", "🚲", "🛵", "🏍", "🛺", "🚝", "🚄", "🚅"]),
        Theme<String>(name: "Buildings", displayCount: 8, color: "green", contents: ["🏰", "🏯", "🏠", "🏡", "🏘", "🏚", "🏭", "🏢", "🏬", "🏣", "🏤", "🏥", "🏦", "🏨", "🏪", "🏫", "🏩", "💒", "⛪️", "🕌", "🕍", "🛕", "🏛", "⛩"]),
        Theme<String>(name: "Countries", displayCount: 10, color: "purple", contents: ["🇨🇳", "🇺🇳", "🇦🇱", "🇩🇿", "🇦🇫", "🇦🇷", "🇦🇪", "🇦🇼", "🇴🇲", "🇦🇿", "🇪🇬", "🇪🇹", "🇮🇪", "🇪🇪", "🇦🇩", "🇦🇴", "🇦🇴", "🇦🇮", "🇦🇬", "🇦🇹", "🇦🇽", "🇦🇺", "🇲🇴", "🇧🇧"]),
    ]
    
    static func createMemoryGame(_ themeId: Int) -> MemoryGame<String>{
        themes[themeId].shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: themes[themeId].displayCount) { index in
            return themes[themeId].fetchOneContent(index) ?? "Error"
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame(0)
    private var themeId: Int = 0
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var color: Color{
        switch EmojiMemoryGame.themes[themeId].color {
            case "blue":
                return .blue
            case "green":
                return .green
            case "purple":
                return .purple
            default:
                return .red
        }
    }
    
    var title: String {
        EmojiMemoryGame.themes[themeId].name
    }
    
    //MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    func newGame(){
        themeId = Int(arc4random_uniform(UInt32(EmojiMemoryGame.themes.count)))
        model = EmojiMemoryGame.createMemoryGame(themeId)
    }
    
}
