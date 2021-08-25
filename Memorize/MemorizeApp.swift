//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ylarod on 2021/8/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
