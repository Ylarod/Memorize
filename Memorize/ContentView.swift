//
//  ContentView.swift
//  Memorize
//
//  Created by Ylarod on 2021/8/20.
//

import SwiftUI

struct ContentView: View {
    var emojisVehicles = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🦽", "🦼", "🛴", "🚲", "🛵", "🏍", "🛺", "🚝", "🚄", "🚅"]
    var emojisBuildings = ["🏰", "🏯", "🏠", "🏡", "🏘", "🏚", "🏭", "🏢", "🏬", "🏣", "🏤", "🏥", "🏦", "🏨", "🏪", "🏫", "🏩", "💒", "⛪️", "🕌", "🕍", "🛕", "🏛", "⛩"]
    var emojisCountries = ["🇨🇳", "🇺🇳", "🇦🇱", "🇩🇿", "🇦🇫", "🇦🇷", "🇦🇪", "🇦🇼", "🇴🇲", "🇦🇿", "🇪🇬", "🇪🇹", "🇮🇪", "🇪🇪", "🇦🇩", "🇦🇴", "🇦🇴", "🇦🇮", "🇦🇬", "🇦🇹", "🇦🇽", "🇦🇺", "🇲🇴", "🇧🇧"]
    
    @State var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🦽", "🦼", "🛴", "🚲", "🛵", "🏍", "🛺", "🚝", "🚄", "🚅"]
    
    @State var emojisTheme = 0;
    @State var emojiCount = 5
    
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
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
            HStack{
                themeVehicles
                Spacer()
                themeBuildings
                Spacer()
                themeCountries
            }.padding(.horizontal)
            
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
    
    var themeVehicles: some View{
        Button{
            emojis = emojisVehicles
            emojis.shuffle()
        } label: {
            VStack{
                Image(systemName: "car.fill")
                Text("Vehicles")
            }
        }
    }
    
    var themeBuildings: some View{
        Button{
            emojis = emojisBuildings
            emojis.shuffle()
        } label: {
            VStack{
                Image(systemName: "building.fill")
                Text("Buildings")
            }
        }
    }
    
    var themeCountries: some View{
        Button{
            emojis = emojisCountries
            emojis.shuffle()
        } label: {
            VStack{
                Image(systemName: "flag.fill")
                Text("Countries")
            }
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
