//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ylarod on 2021/8/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
