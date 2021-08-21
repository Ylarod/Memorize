//
//  ContentView.swift
//  Memorize
//
//  Created by Ylarod on 2021/8/20.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🦽", "🦼", "🛴", "🚲", "🛵", "🏍", "🛺", "🚝", "🚄", "🚅"]
    @State var emojiCount = 5
    
    
    var body: some View {
        VStack {
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.red)
            }
            Spacer()
            HStack{
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding()
    }
    
    
    var remove : some View{
        Button {
            if emojiCount > 1{
                emojiCount -= 1
            }
        } label: {
            VStack{
                Image(systemName: "minus.circle")
            }
        }
    }
    
    var add : some View{
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}

struct CardView : View {
    var content : String
    @State var isFaceUp : Bool = true
    
    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3.0)
                Text(content).font(.largeTitle)
            }else{
                shape.fill().foregroundColor(.red)
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
