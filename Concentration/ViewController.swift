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

    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
    
    //add instance variable
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var score = 0 {
        didSet {
            scoreCountLabel.text = "Scores: \(scoreCountLabel)"
        }
    }
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    //array of UI Buttons
    @IBOutlet var cardButtons: [UIButton]!
    
    //controller starts new game
    @IBAction func startNewGame(_ sender: UIButton) {
        //create new fresh board
        game.newGame()
        //wipe old dictionary
        emoji = [Int:String]()
        //restore old emoji lists
        emojiThemes = restore()
        //chose new theme
        theme = chooseTheme()
        flipCount = 0
        //update view based on model update
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
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
    
    func updateViewFromModel() {
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
    
    
    lazy var theme = chooseTheme()
    let emojiThemeStore = [["😛", "😋", "😏", "😎", "😇", "😍"],
                           ["😺", "😸","😹", "😻", "😼", "😽" ],
                           ["🤲", "👐", "🙌", "👏", "🤝", "👍"]]
    lazy var emojiThemes = emojiThemeStore
    var emoji = [Int:String]()
    
    func emojiForCard(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiThemes.count > 0{
            //if the card has an identifier, and we have emojis in the emojiTheme
            if emojiThemes[theme].count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiThemes[theme].count)))
                emoji[card.identifier] = emojiThemes[theme].remove(at: randomIndex)
            }
        }
        //if our card identifier to emoji mapping exists, return the emoji, otherwise ?
        return emoji[card.identifier] ?? "?"
    }
    
    
    func chooseTheme() -> Int{
        //randomly choose an index from emojiChoices
        return Int(arc4random_uniform(UInt32(emojiThemes.count)))
    }
    
    func restore() -> [[String]] {
        return emojiThemeStore
    }
    

}

