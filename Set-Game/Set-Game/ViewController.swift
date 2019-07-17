//
//  ViewController.swift
//  Set-Game
//
//  Created by Madalina Sinca on 15/07/2019.
//  Copyright © 2019 Madalina Sinca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var game = Game()
    
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }

    @IBOutlet weak private var setCountLabel: UILabel!
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet weak private var deckCountLabel: UILabel!
    
    
    @IBAction private func newGame(_ sender: UIButton) {
        game.reset()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else { print("chosen card was not in cardButtons") }
    }
    
    @IBOutlet weak private var dealCardsButton: UIButton!
    
    @IBAction private func dealCards(_ sender: UIButton) {
        game.dealThreeCards()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        deckCountLabel.text = "DECK: \(game.deckCount)"
        scoreLabel.text = "SCORE: \(game.score)"
        setCountLabel.text = "SETS: \(game.cardsSets.count)"
        
        if game.cardsOnTable.count < 27, game.deckCount > 0 {
            dealCardsButton.isEnabled = true
        } else { dealCardsButton.isEnabled = false }
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if index < game.cardsOnTable.count {
                let card: Card? = game.cardsOnTable[index]
                
                if let card = card, game.cardsOnTable.contains(card) {
                    button.setAttributedTitle(attributedStringForCard(game.cardsOnTable[index]), for: .normal)
                    button.isEnabled = true
                    button.isHidden = false
                    button.layer.backgroundColor = #colorLiteral(red: 0.9096221924, green: 0.9060236216, blue: 0.8274506927, alpha: 1)
                    
                    button.layer.cornerRadius = 8.0
                }
            } else {
                button.isHidden = true
                
                button.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
            }
            
        }
        // TODO
    }
    
    private func attributedStringForCard(_ card: Card) -> NSAttributedString {
        let cardSymbol: String = {
            switch card.symbol {
            case .triangle: return "▲"
            case .circle: return "●"
            case .square: return "■"
            }
        }()
        
        let color: UIColor = {
            switch card.color {
            case .red: return #colorLiteral(red: 0.968746841, green: 0.777038753, blue: 0.3501046896, alpha: 1)
            case .green: return #colorLiteral(red: 0.8050321937, green: 0.3532711267, blue: 0.4588070512, alpha: 1)
            case .purple: return #colorLiteral(red: 0.2275798917, green: 0.6626726985, blue: 0.6195083261, alpha: 1)
            }
        }()
        
        let strokeWidth: CGFloat = {
            switch card.decoration {
            case .striped: return -15
            case .filled: return -15
            case .outline: return 15
            }
        }()
        
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeColor: color,
            .strokeWidth: strokeWidth,
            .foregroundColor: color.withAlphaComponent({
                switch card.decoration {
                case .striped: return 0.20
                case .filled: return 1.0
                case .outline: return 0.0
                }
                }()
            )
        ]
        
        let cardTitle: String = {
            switch card.number {
            case .one: return cardSymbol
            case .two: return cardSymbol + " " + cardSymbol
            case .three: return cardSymbol + " " + cardSymbol + " " + cardSymbol
            }
        }()
        
        return NSAttributedString(string: cardTitle, attributes: attributes)
    }
}

