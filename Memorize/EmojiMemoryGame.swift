//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ylarod on 2021/8/24.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static var themes = [
        Theme<String>(name: "Halloween", displayCount: 4, color: "blue", contents: ["👻","🎃", "🕷"]),
        Theme<String>(name: "Buildings", displayCount: 8, color: "green", contents: ["🏰", "🏯", "🏠", "🏡", "🏘", "🏚", "🏭", "🏢", "🏬", "🏣", "🏤", "🏥", "🏦", "🏨", "🏪", "🏫", "🏩", "💒", "⛪️", "🕌", "🕍", "🛕", "🏛", "⛩"]),
        Theme<String>(name: "Countries", displayCount: 10, color: "purple", contents: ["🇨🇳", "🇺🇳", "🇦🇱", "🇩🇿", "🇦🇫", "🇦🇷", "🇦🇪", "🇦🇼", "🇴🇲", "🇦🇿", "🇪🇬", "🇪🇹", "🇮🇪", "🇪🇪", "🇦🇩", "🇦🇴", "🇦🇴", "🇦🇮", "🇦🇬", "🇦🇹", "🇦🇽", "🇦🇺", "🇲🇴", "🇧🇧"]),
        Theme<String>(name: "Vehicles", displayCount: 4, color: "blue", contents: ["🚙", "🚗", "🚘", "🚕", "🚖", "🏎", "🚚", "🛻", "🚛", "🚐", "🚓", "🚔", "🚑", "🚒", "🚀", "✈", "🛫", "🛬", "🛩", "🚁", "🛸", "🚲", "🏍", "🛶", "⛵", "🚤", "🛥", "🛳", "⛴", "🚢", "🚂", "🚝", "🚅", "🚆", "🚊", "🚉", "🚇", "🛺", "🚜"]),
        Theme<String>(name: "Sports", displayCount: 4, color: "blue", contents: ["🏈", "⚾", "🏀", "⚽", "🎾", "🏐", "🥏", "🏓", "⛳", "🥅", "🥌", "🏂", "⛷", "🎳"]),
        Theme<String>(name: "Music", displayCount: 4, color: "blue", contents: ["🎼", "🎤", "🎹", "🪘", "🥁", "🎺", "🪗", "🪕", "🎻"]),
        
        Theme<String>(name: "AnimalFaces", displayCount: 4, color: "blue", contents: ["🐵", "🙈", "🙊", "🙉", "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐲"]),
        Theme<String>(name: "Flora", displayCount: 4, color: "blue", contents: ["🌲", "🌴", "🌿", "☘", "🍀", "🍁", "🍄", "🌾", "💐", "🌷", "🌹", "🥀", "🌺", "🌸", "🌼", "🌻"]),
        Theme<String>(name: "Weather", displayCount: 4, color: "blue", contents: ["☀️", "🌤", "⛅", "🌥", "☁", "🌦", "🌧", "⛈", "🌩", "🌨", "❄️", "💨", "☔", "💧", "💦", "🌊", "☂️", "🌫", "🌪"]),
        Theme<String>(name: "COVID", displayCount: 4, color: "blue", contents: ["💉", "🦠", "😷", "🤧", "🤒"]),
        Theme<String>(name: "Animals", displayCount: 4, color: "blue", contents: ["🐥", "🐣", "🐂", "🐄", "🐎", "🐖", "🐏", "🐑", "🦙", "🐐", "🐓", "🐁", "🐀", "🐒", "🦆", "🦅", "🦉", "🦇", "🐢", "🐍", "🦎", "🦖", "🦕", "🐅", "🐆", "🦓", "🦍", "🦧", "🦣", "🐘", "🦛", "🦏", "🐪", "🐫", "🦒", "🦘", "🦬", "🐃", "🦙", "🐐", "🦌", "🐕", "🐩", "🦮", "🐈", "🦤", "🦢", "🦩", "🕊", "🦝", "🦨", "🦡", "🦫", "🦦", "🦥", "🐿", "🦔"]),
        Theme<String>(name: "Faces", displayCount: 4, color: "blue", contents: ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "🥲", "☺️", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "🥰", "😘", "😗", "😙", "😚", "😋", "😛", "😝", "😜", "🤪", "🤨", "🧐", "🤓", "😎", "🥸", "🤩", "🥳", "😏", "😞", "😔", "😟", "😕", "🙁", "☹️", "😣", "😖", "😫", "😩", "🥺", "😢", "😭", "😤", "😠", "😡", "🤯", "😳", "🥶", "😥", "😓", "🤗", "🤔", "🤭", "🤫", "🤥", "😬", "🙄", "😯", "😧", "🥱", "😴", "🤮", "😷", "🤧", "🤒", "🤠"]),
    ]
    
    private static func createMemoryGame(_ themeId: Int) -> MemoryGame<String>{
        themes[themeId].shuffled()
        let numberOfPairsOfCards = Int.random(in: 3...20)
        themes[themeId].changeDisplayCount(count: numberOfPairsOfCards)
        print("random numberOfPairsOfCards: \(numberOfPairsOfCards)")
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { index in
            return themes[themeId].fetchOneContent(index) ?? "Error"
        }
    }
    
    @Published private var model = createMemoryGame(0)
    private var themeId: Int = 0
    
    var cards: Array<Card> {
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
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func restart(){
        model = EmojiMemoryGame.createMemoryGame(themeId)
    }
    
    func newGame(){
        themeId = Int(arc4random_uniform(UInt32(EmojiMemoryGame.themes.count)))
        model = EmojiMemoryGame.createMemoryGame(themeId)
    }
    
}
