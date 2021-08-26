//
//  Theme.swift
//  Memorize
//
//  Created by Ylarod on 2021/8/26.
//

import Foundation

struct Theme<CardContent>{
    private(set) var name: String
    private(set) var displayCount: Int
    private(set) var color: String
    private var contents: Array<CardContent>
    
    init(name: String, displayCount: Int, color: String, contents: Array<CardContent>) {
        self.name = name
        self.contents = contents.shuffled()
        self.displayCount = displayCount < contents.count ? displayCount : contents.count
        self.color = color
    }
    
    mutating func fetchOneContent(_ index: Int) -> CardContent? { // return nil when inavailable
        if index >= 0 && index < displayCount {
            return contents[index]
        }
        return nil
    }
    
    mutating func changeDisplayCount(count: Int){
        if count > contents.count {
            displayCount = contents.count
        }else if count < 1{
            displayCount = 1
        }else{
            displayCount = count
        }
    }
    
    mutating func shuffled(){
        contents = contents.shuffled()
    }
}
