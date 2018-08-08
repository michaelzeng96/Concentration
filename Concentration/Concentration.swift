//
//  Concentration.swift
//  Concentration
//
//  Created by Michael Zeng on 7/26/18.
//  Copyright © 2018 Michael Zeng. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            //if there is one face up card, we set it as our computed property
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(indexValue){
            for index in cards.indices {
                cards[index].isFaceUp = (index == indexValue)
            }
        }
    }
    var reset = false

    mutating func chooseCard(at index: Int){
        //ensure that we are within index
        assert(cards.indices.contains(index), "Concentration.choseCard(at: \(index): chosen index not at card")
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
            } else {
                //set oneAndOnlyFaceUpCard's index
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards>0, "Concentration.init(nuberOfPairsOfCards: \(numberOfPairsOfCards): Our game should have more than 0 pairs of cards!")
        //for the number that our class is initialized to, create that many pairs of cards
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
    }
    
}
