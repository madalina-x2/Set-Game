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
    
    @IBAction private func dealCards(_ sender: UIButton) {
        game.dealThreeCards()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        // TODO
    }
    
}

