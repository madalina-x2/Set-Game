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
        set {
            if newValue != nil {
                switch newValue! {
                case true:
                    cardsSets.append(cardsSelected)
                    // replace matched card(s)
                    cardsSelected.removeAll()
                    // score bonus ?
                case false:
                    cardsSelected.removeAll()
                    // score penalty
                }
            } else { cardsSelected.removeAll() }
        }
        
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cardsOnTable.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        let choosenCard = cardsOnTable[index]
        
        switch cardsSelected {
            case let cardsForSet where cardsForSet.count == 3:
                isSet = isSet
            case let cardsForSet where !cardsForSet.contains(choosenCard):
                cardsSelected.append(choosenCard)
            default:
                cardsSelected = cardsSelected.filter() { $0 != choosenCard }
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
