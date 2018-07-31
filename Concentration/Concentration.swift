//
//  Concentration.swift
//  Concentration
//
//  Created by Michael Zeng on 7/26/18.
//  Copyright © 2018 Michael Zeng. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var reset = false

    func chooseCard(at index: Int){
        //ignore already matched cards
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if there is already one flipped up card, and that you're not choosing the same card
                print("card identifiers \(cards[matchIndex].identifier) and \(cards[index].identifier)")
                if cards[matchIndex].identifier == cards[index].identifier {
                    //check if your chosen card emoji identifier matches the already flipped up card
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    //flip all cards over
                    cards[flipDownIndex].isFaceUp = false
                }
                //flip newly selected card up
                cards[index].isFaceUp = true
                //set oneAndOnlyFaceUpCard's index
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        //for the number that our class is initialized to, create that many pairs of cards
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
    func newGame(){
        reset = false
        shuffleCards()
        resetCards()
    }
    
    func shuffleCards(){
        var last = cards.count - 1
        while(last > 0) {
            let rand = Int(arc4random_uniform(UInt32(last)))
            cards.swapAt(last, rand)
            last -= 1
        }
    }
    
    func resetCards(){
        for i in 0..<cards.count {
            //turn all cards down and unmatch them
            cards[i].isFaceUp = false
            cards[i].isMatched = false
        }
    }
    
}
