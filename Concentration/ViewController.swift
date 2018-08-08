//
//  ViewController.swift
//  Concentration
//
//  Created by Michael Zeng on 7/24/18.
//  Copyright © 2018 Michael Zeng. All rights reserved.
//

// brings top cocoa touch layer, button, etc
import UIKit


// UIViewController knows everything about the UI, we are inheriting from it
class ViewController: UIViewController {

    //don't want people to change how many cards are generated in our model
    //since this value is currently tied initmately to our UI
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count / 2)
        }
    }
    
    //we don't want people to control how many flips we are recording
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    //Outlets and Buttons are internally implementations of how UI looks
    @IBOutlet private weak var scoreCountLabel: UILabel!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    //array of UI Buttons
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print("cardNumber = \(cardNumber)")
        }
        else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        //update every button view and its respective model data
        for index in cardButtons.indices {
            // get UIButton and its respective card object
            let button = cardButtons[index]
            let card = game.cards[index]
            //check if card is face up
            if card.isFaceUp {
                //populate the uibutton with an emoji
                button.setTitle(emojiForCard(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else { //if card is face down
                //make card orange if unmatched, otherwise make it transparent
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5595000386, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5595000386, blue: 0, alpha: 1)
            }
        }
    }
    
    
    private var emojiChoices = "😛😋😏😎😇😍"
    private var emoji = [Card:String]()
    
    private func emojiForCard(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0{
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        //if our card identifier to emoji mapping exists, return the emoji, otherwise ?
        return emoji[card] ?? "?"
    }
    
}

//extension of int to generate random integer
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else{
            return 0
        }
    }
}

