//
//  Game.swift
//  Set-Game
//
//  Created by Madalina Sinca on 16/07/2019.
//  Copyright © 2019 Madalina Sinca. All rights reserved.
//

import Foundation

struct Game {
    
    private var deck = CardDeck()
    var deckCount: Int { return deck.cards.count }
    
    private(set) var cardsOnTable = [Card]()
    private(set) var cardsSelected = [Card]()
    private(set) var cardsSets = [[Card]]()
    
    private var isSet: Bool? {
        get {
            guard cardsSelected.count == 3 else { return nil }
            return cardsSelected.isSet()
        }
        
    }
}

private extension Array where Element == Card {
    func isSet() -> Bool {
        let number     = Set(self.map { $0.number } )
        let symbol     = Set(self.map { $0.symbol } )
        let decoration = Set(self.map { $0.decoration } )
        let color      = Set(self.map { $0.color } )
        
        return  number.count != 2 && symbol.count != 2 && decoration.count != 2 && color.count != 2
    }
}
